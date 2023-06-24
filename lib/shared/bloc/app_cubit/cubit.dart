import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x_pone/models/blogs_model.dart';
import 'package:x_pone/screens/home_Page.dart';
import 'package:x_pone/screens/setting_Page.dart';
import 'package:x_pone/screens/all_bicnic_Page.dart';
import 'package:x_pone/screens/allExercises_Page.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';
import 'package:x_pone/shared/componants/components.dart';
import 'package:x_pone/shared/network/remote/cache_helper.dart';

import '../../../models/blogs_model.dart';
import '../../../models/doctors_model.dart';
import '../../../models/editProfile_model.dart';
import '../../../models/login_model.dart';
import '../../../models/profile_model.dart';
import '../../network/endpoint.dart';
import '../../network/local/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int pageIndex = 0;

  List<Widget> bottomScreens = [
    home_page(),
    allExercisesPage(),
    allClinicsPage(),
    setting_page(),
  ];

  void changeBottom(int index) {
    pageIndex = index;
    emit(AppChangeBottomNavStates());
  }

  List<ArticlesModel>? articles;
  List<DataBlog> articlesModel = [];

  Future<void> getArticles() async {
    try {
      final value = await DioHelper.getdata(url: ARTICLE);
      final data = value.data['data'];
      if (data is List) {
        articlesModel = data.map((e) => DataBlog.fromJson(e)).toList();
      }
      print(articlesModel);
      emit(xBoneSuccessArticlesStates());
    } catch (error) {
      print(error.toString());
      emit(xBoneErrorArticlesStates(error.toString()));
    }
  }

  List<DataDoctor>? doctorList;

  Future<void> getDoctorsModel() async {
    try {
      final value = await DioHelper.getdata(url: DOCTORS);
      final data = value.data['data'];
      if (data is List) {
        doctorList = data.map((e) => DataDoctor.fromJson(e)).toList();
      }
      print(doctorList);
      emit(xBoneSuccessDoctorsStates());
    } catch (error) {
      print(error.toString());
      emit(xBoneErrorDoctorsStates(error.toString()));
    }
  }

  File? image;
  var imagePicker = ImagePicker();
  var pickedImage;
  uploadImage() async {
    try {
      emit(ProfileUpdatePickedImageLoadingState());
      pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);

        try {
          FormData formData = FormData.fromMap({
            'image': await MultipartFile.fromFile(image!.path),
          });
          Response response = await Dio().post(
            "https://x-bone.innovadigits.com/api/$update_profile",
            data: formData,
          );
          print(response.data);
          emit(ProfileUpdatePickedImageDoneState());
        } catch (e) {
          print('Error uploading image: $e');
          emit(ProfileUpdatePickedImageErrorState());
        }
      } else {
        // Handle the case when no image was picked
        emit(ProfileUpdateNoImagePickedState());
      }
    } catch (e) {
      print('Error picking image: $e');
      emit(ProfileUpdateImagePickErrorState());
    }
  }

  // بتوع تعديل البروفايل
  // xBoneProfileModel? updateUserModel;
  xBoneProfileModel? userModel;
  void updateUserData({
    required String name,
    required String email,
    required String phone,
    required String lat,
    required String long,
    required String mainImage,
    required String password,
  }) async {
    emit(xBoneLoadingUpdateUserDataState());
    try {
      final response = await DioHelper.postdata(
        url: update_profile,
        headers: {
          // 'contentType': 'multipart/form-data',
          'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
        },
        posteddata: userModel!.data!.email != email
            ? {
                'name': name,
                'email': email,
                'phone': phone,
                'lat': lat,
                'long': long,
              }
            : {
                'name': name,
                'phone': phone,
                'lat': lat,
                'long': long,
              },
      );
      print(response);
      userModel = xBoneProfileModel.fromJson(response.data);
      emit(xBoneSuccessUpdateUserDataState(userModel!));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      print(error);
      emit(xBoneErrorUpdateUserDataState(error));
    }
  }

  // بتوع البروفايل
  getUserData({access_token}) {
    emit(xBoneLoadingUserDataState());
    DioHelper.getdata(
      url: PROFILE,
      headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer ${access_token ?? token}",
      },
    ).then((value) {
      userModel = xBoneProfileModel.fromJson(value.data);
      emit(xBoneSuccessUserDataState(userModel!));
      print(userModel);
      if (kDebugMode) {
        print(userModel?.data?.name);
      }
      if (kDebugMode) {
        print(value.data);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(xBoneErrorUserDataState());
    });
  }
}

// void calculateDistance() async {
//   Position position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );

//   double latitude = position.latitude;
//   double longitude = position.longitude;
//   if (kDebugMode) {
//     print(latitude);
//   }
//   if (kDebugMode) {
//     print(longitude);
//   }
// }


// void getProfil() {
//
//   emit(ProfilLoadingtState());
//   DioHelper.getdata(
//     url: GETPROFIL,
//     headers: {
//       'Accept': 'application/json',
//       'Authorization': "Bearer ${token}",
//     },
//   ).then((value) {
//     print(value);
//     myProfil = RegisterModrl.fromJson(value.data);
//     // print(myProfil!.team.attributes.body);
//     // print(myProfil!.data?.email);
//
//
//     emit(ProfilSuccessState());
//
//     // print(team_id);
//     print("team_id");
//   });
// }
