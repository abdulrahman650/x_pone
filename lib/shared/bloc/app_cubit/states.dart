



import 'package:x_pone/models/doctors_model.dart';
import 'package:x_pone/models/login_model.dart';

import '../../../models/blogs_model.dart';
import '../../../models/blogs_model.dart';
import '../../../models/blogs_model.dart';
import '../../../models/editProfile_model.dart';
import '../../../models/profile_model.dart';

abstract class AppStates {}

class AppInitStates extends AppStates {}

class AppChangeModeStates extends AppStates {}

class AppChangeBottomNavStates extends AppStates {}

//-----Home--------------------------------------------
class AppLoadingHomeDataStates extends AppStates {}
class AppSuccessHomeDataStates extends AppStates {}
class AppErrorHomeDataStates extends AppStates {}


//---Articles----------------------------------------------------
class xBoneSuccessArticlesStates extends AppStates {
  late final ArticlesModel articlesModel;
  xBoneSuccessArticlesStates();
}
class xBoneErrorArticlesStates extends AppStates {
  final String error;
  xBoneErrorArticlesStates(this.error);
}
class xBoneLoadingArticlesStates extends AppStates {}

//---Doctors----------------------------------------------------
class xBoneSuccessDoctorsStates extends AppStates {
}
class xBoneErrorDoctorsStates extends AppStates {
  final String error;
  xBoneErrorDoctorsStates(this.error);
}
class xBoneLoadingDoctorsStates extends AppStates {}

//----Clinics---------------------------------------------------
class AppSuccessClinicsStates extends AppStates {}
class AppErrorClinicsStates extends AppStates {
  final String error;
  AppErrorClinicsStates(this.error);
}

// class AppFavoritesStates extends AppStates {}


//------Profile-------------------------------------------------------
class xBoneLoadingUserDataState extends AppStates{}
class xBoneSuccessUserDataState extends AppStates{
 late final xBoneProfileModel userModel;
 xBoneSuccessUserDataState(this.userModel);
}
class xBoneErrorUserDataState extends AppStates{}


//--------Update Profile----------------------------------------------------
class xBoneLoadingUpdateUserDataState extends AppStates{}

class xBoneSuccessUpdateUserDataState extends AppStates{
 late final xBoneProfileModel updateUserModel;
 xBoneSuccessUpdateUserDataState(this.updateUserModel);
}
class xBoneErrorUpdateUserDataState extends AppStates{
  xBoneErrorUpdateUserDataState(error);
}
class ProfileSuccessUpdatePickedImageState extends AppStates{

}
class ProfileErrorUpdatePickedImageState extends AppStates{
  ProfileErrorUpdatePickedImageState(error);
}









