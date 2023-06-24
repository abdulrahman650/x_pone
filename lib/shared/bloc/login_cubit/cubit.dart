import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_pone/models/login_model.dart';
import 'package:x_pone/shared/bloc/login_cubit/states.dart';
import 'package:x_pone/shared/network/remote/cache_helper.dart';

class xBoneLoginCubit extends Cubit<xBoneLoginState> {
  xBoneLoginCubit() : super(xBoneLoginInitialState());

  static xBoneLoginCubit get(context) => BlocProvider.of(context);

  xBoneLoginModel? loginModel;

  Future<void> userLogin({
    required String email,
    required String password,
    required context,
  }) async {
    emit(xBoneLoginLoadingState());
    try {
      final response =
      await Dio().post("https://x-bone.innovadigits.com/api/login",
          data: FormData.fromMap({
            "email": email,
            "password": password,
          }));
      if (response.statusCode == 200) {
        loginModel = xBoneLoginModel.fromJson(response.data);
        CacheHelper.saveToken("${response.data['access_token']}");
        
        print(response.data);
        emit(xBoneLoginSuccessState(loginModel!));
      } else {
        emit(xBoneLoginErrorState(response.data));
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        emit(xBoneLoginErrorState("Connection timeout."));
      } else if (e.type == DioErrorType.receiveTimeout) {
        emit(xBoneLoginErrorState("Receive timeout."));
      } else if (e.type == DioErrorType.other) {
        emit(xBoneLoginErrorState("${e.response?.data}"));
      } else if (e.type == DioErrorType.cancel) {
        emit(xBoneLoginErrorState("Request canceled."));
      } else {
        emit(xBoneLoginErrorState("Unknown error: $e"));
      }
    }
  }

  bool isShown = true;
  IconData iconData = Icons.visibility;

  void changePasswordVisibility() {
    isShown = !isShown;
    iconData = isShown ? Icons.visibility : Icons.visibility_off_sharp;

    emit(xBoneLoginChangePasswordVisibilityState());
  }
}