import 'package:x_pone/models/login_model.dart';

abstract class xBoneLoginState{}

class xBoneLoginInitialState extends xBoneLoginState{}

class xBoneLoginLoadingState extends xBoneLoginState{}

class xBoneLoginSuccessState extends xBoneLoginState
{
  final xBoneLoginModel loginModel;

  xBoneLoginSuccessState(this.loginModel);
}

class xBoneLoginErrorState extends xBoneLoginState{

  final String error;
  xBoneLoginErrorState(this.error);
}
class xBoneLoginChangePasswordVisibilityState extends xBoneLoginState {}
