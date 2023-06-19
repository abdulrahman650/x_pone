import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_pone/models/login_model.dart';
import 'package:x_pone/shared/bloc/login_cubit/states.dart';
import 'package:x_pone/shared/network/local/dio_helper.dart';

import '../../network/endpoint.dart';
import '../app_cubit/cubit.dart';
import '../register_cubit/states.dart';

class xBoneLoginCubit extends Cubit<xBoneLoginState> {
  xBoneLoginCubit(): super(xBoneLoginInitialState());

   static xBoneLoginCubit get(context) => BlocProvider.of(context);

     xBoneLoginModel? loginModel;
  // Future<void> userLogin(
  //     {
  //       required String email,
  //       required String password,
  //     }
  //     ) async {
  //   emit(xBoneLoginLoadingState());
  //   try {
  //     final response = await Dio().post("https://x-bone.innovadigits.com/api/login", data: {
  //       'email': email,
  //       'password': password,
  //     });
  //     if (response.statusCode == 200) {
  //       loginModel = xBoneLoginModel.fromJson(response.data);
  //       emit(xBoneLoginSuccessState(loginModel!));
  //     } else {
  //       emit(xBoneLoginErrorState( response.data));
  //     }
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.connectTimeout) {
  //       emit(xBoneLoginErrorState( "Connection timeout."));
  //     } else if (e.type == DioErrorType.receiveTimeout) {
  //       emit(xBoneLoginErrorState( "Receive timeout."));
  //     } else if (e.type == DioErrorType.other) {
  //       emit(xBoneLoginErrorState( "${e.response?.data}"));
  //     } else if (e.type == DioErrorType.cancel) {
  //       emit(xBoneLoginErrorState( "Request canceled."));
  //     } else {
  //       emit(xBoneLoginErrorState( "Unknown error: $e"));
  //     }
  //   }
  // }

   userLogin({
    required String email,
    required String password,
    required context
  }) {
     print(email);
     print(password);
     print("abdoooooooooooooooooooooooooo");
    emit(xBoneLoginLoadingState());

    DioHelper.postdata(
      url: LOGIN,
      posteddata: {
        'email': email,
        'password': password,
      },
    ).then((value) async{
       loginModel=
          xBoneLoginModel.fromJson(value.data);
      emit(xBoneLoginSuccessState(loginModel!));
       print(value.data);
       print('doneeeeeeeeeeeeeee');

     await  AppCubit.get(context).getArticles();
     await  AppCubit.get(context).getUserData();



    }).catchError((error) {

      print(error.toString());
      emit(xBoneLoginErrorState(error.toString()));
    });
  }






  bool isShown = true;
  IconData iconData = Icons.visibility;

  void changePasswordVisibility() {
    isShown = !isShown;
    iconData = isShown ? Icons.visibility : Icons.visibility_off_sharp;

    emit(xBoneLoginChangePasswordVisibilityState());
  }
}
