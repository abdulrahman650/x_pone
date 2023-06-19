
import '../../../models/Register_model.dart';
import '../../../models/login_model.dart';

abstract class xBoneRegisterStates {}

class xBoneRegisterInitState extends xBoneRegisterStates {}


class xBoneRegisterLoadingState extends xBoneRegisterStates{}

class xBoneRegisterSuccessState extends xBoneRegisterStates
{
  final xBoneRegisterModel RegisterModel;

  xBoneRegisterSuccessState(this.RegisterModel);
}

class xBoneRegisterErrorState extends xBoneRegisterStates{

  final String error;
  xBoneRegisterErrorState(this.error);
}


class xBoneRegisterChangePasswordVisibilityState extends xBoneRegisterStates {}
