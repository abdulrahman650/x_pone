// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:x_pone/models/blogs_model.dart'as datamodel;
import 'package:x_pone/screens/homePage.dart';
import 'package:x_pone/screens/settingPage.dart';
import 'package:x_pone/screens/all_bicnic_Page.dart';
import 'package:x_pone/screens/allExercises_Page.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';
import 'package:x_pone/shared/componants/components.dart';

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
    homePage(),
    allExercisesPage(),
    allClinicsPage(),
    setting_page(),
  ];

  void changeBottom(int index) {
    pageIndex = index;
    emit(AppChangeBottomNavStates());
    if (index == 2) {
      emit(AppSuccessClinicsStates());
    }
    if (index == 3) {
      emit(xBoneSuccessUserDataState(userModel!));

    }
  }

  // HomeModel? homeModel;
  // void getHomeData() {
  //   emit(AppLoadingHomeDataStates());
  //   DioHelper.getData(url: home, token: token).then((value) {
  //     homeModel = HomeModel.fromJson(value.data);
  //     for (var element in homeModel!.data.products) {
  //       favorites.addAll({
  //         element.id: element.inFavorites,
  //       });
  //     }
  //     //debugPrint(favorites.toString());
  //     //debugPrint(token);
  //     emit(AppSuccessHomeDataStates());
  //   }).catchError((onError) {
  //     debugPrint(onError.toString());
  //     emit(AppErrorHomeDataStates());
  //   });
  // }
  //

  datamodel.Data? articlesModel;
 List<datamodel.Data>? articles;
   getArticles() {
    DioHelper.getdata(
      url: ARTICLE,
    ).then((value) {

      // print(value.data);
    articles!.add(datamodel.Data.fromJson(value.data));
      print(articles);
      emit(xBoneSuccessArticlesStates());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(xBoneErrorArticlesStates(onError.toString()));
    });
  }

  DoctorsModel? doctorModel;
 List<DoctorsModel>? doctorList;
   getDoctorsModel() {
    DioHelper.getdata(
      url: DOCTORS,
    ).then((value) {
      print(value.toString());
      doctorList!.add(DoctorsModel.fromJson(value.data));
      emit(xBoneSuccessDoctorsStates(doctorModel!));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(xBoneErrorDoctorsStates(onError.toString()));
    });
  }
  //
  //


  // بتوع تعديل البروفايل
  // xBoneProfileModel? updateUserModel;
  xBoneProfileModel? userModel;
  void updateUserData({
    required String name,
    required String email,
    required String phone,
    required String lat,
    required String long,
    required String image,
    required String password,
  }) {
    //مع العلم الداتا عندي نوعها بوست
    emit(xBoneLoadingUpdateUserDataState());
    DioHelper.putdata(
      url: update_profile,
      headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      },
      // token: token,
      posteddata: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'lat': lat,
        'long': long,
        'image': null,
      },
    ).then((value) {
      userModel = xBoneProfileModel.fromJson(value.data);
      // updateUserModel = xBoneProfileModel.fromJson(value.data);
      emit(xBoneSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(xBoneErrorUpdateUserDataState(error));
    });
  }

  //
  //
  // Map<int, bool> favorites = {};
  // GetFavoritesModel? getFavoritesModel;
  //
  // void changeFavorites(int productId) {
  //   favorites[productId] = !favorites[productId]!;
  //   emit(AppFavoritesStates());
  //   DioHelper.postData(
  //     path: FAVORITES,
  //     data: {
  //       'product_id': productId,
  //     },
  //     token: token,
  //   ).then((value) {
  //     getFavoritesModel = GetFavoritesModel.fromJson(value.data!);
  //     if (getFavoritesModel!.status == false) {
  //       favorites[productId] = !favorites[productId]!;
  //     } else {
  //       getFav();
  //       emit(AppChangeFavoritesStates());
  //     }
  //     emit(AppSuccessFavoritesStates(getFavoritesModel!));
  //   }).catchError((onError) {
  //     favorites[productId] = !favorites[productId]!;
  //     emit(AppErrorFavoritesStates());
  //   });
  // }
  //
  // FavoritesModel? favoritesModel;
  //
  // void getFav() {
  //   emit(AppLoadingGetFavoritesStates());
  //   DioHelper.getData(
  //       url: FAVORITES,
  //       token: token
  //   ).then((value)
  //   {
  //     favoritesModel = FavoritesModel.fromJson(value.data);
  //     // debugPrint(value.data.toString());
  //     emit(AppSuccessGetFavoritesStates());
  //   }).catchError((onError) {
  //     debugPrint(onError.toString());
  //     emit(AppErrorGetFavoritesStates());
  //   });
  // }

  // xBoneProfileModel? userModel;
//الداتا بتاعت البروفايل
   getUserData() {

    emit(xBoneLoadingUserDataState());

    DioHelper.getdata(
      url: PROFILE,
          headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    },
      // token: token,
    ).then((value) {
      userModel = xBoneProfileModel.fromJson(value.data);
      emit(xBoneSuccessUserDataState(userModel!));
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
void calculateDistance() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  double latitude = position.latitude;
  double longitude = position.longitude;
  print(latitude);
  print(longitude);
}
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
