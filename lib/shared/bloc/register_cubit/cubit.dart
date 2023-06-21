
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_pone/shared/bloc/register_cubit/states.dart';
import 'package:x_pone/shared/network/local/dio_helper.dart';
import 'package:x_pone/shared/network/remote/cache_helper.dart';

import '../../../models/Register_model.dart';
import '../../../models/login_model.dart';
import '../../network/endpoint.dart';


class xBoneRegisterCubit extends Cubit<xBoneRegisterStates> {
  xBoneRegisterCubit() : super(xBoneRegisterInitState());

  static xBoneRegisterCubit get(context) => BlocProvider.of(context);

   late xBoneRegisterModel? RegisterModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String lat,
    required String long,
    // required String location,
  }) {
    emit(xBoneRegisterLoadingState());
    DioHelper.postdata(
      url: REGISTER,
      posteddata: {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
        'lat':lat,
        'long':long,



      },

    ).then(
      (value) {
        RegisterModel = xBoneRegisterModel.fromJson(value.data);
        // CacheHelper.saveToken(value.data['access_token']);
      CacheHelper.putData(key: 'token', value: value.data['access_token']);
        print('sssssssssssssssssssssssssssssss rigestrer');
        CacheHelper.saveLoginData("email", email);
        CacheHelper.saveLoginData("password", password);
        CacheHelper.saveLoginData("name", name);
        CacheHelper.saveLoginData("phone", phone);
        CacheHelper.putDataList(key: "userData", value: [email, password, name, phone,lat, long]);
        emit(xBoneRegisterSuccessState(RegisterModel!));
      },
    ).catchError((onError) {
      print(onError.toString());

      emit(xBoneRegisterErrorState(onError.toString()));
      debugPrint(onError.toString());

    });
  }

  bool isShown = true;
  IconData iconData = Icons.visibility;

  void changePasswordVisibility() {
    isShown = !isShown;
    iconData = isShown ? Icons.visibility : Icons.visibility_off_sharp;

    emit(xBoneRegisterChangePasswordVisibilityState());
  }
}
