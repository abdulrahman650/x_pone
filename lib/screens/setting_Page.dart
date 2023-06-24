import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';
import 'package:x_pone/shared/bloc/login_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/register_cubit/cubit.dart';
import 'package:x_pone/shared/styles/colors.dart';

import '../controller/login/login_design.dart';
import '../models/Register_model.dart';
import '../models/editProfile_model.dart';
import '../models/login_model.dart';
import '../models/profile_model.dart';
import '../shared/componants/components.dart';
import '../shared/network/remote/cache_helper.dart';
import 'home_Page.dart';
import 'location.dart';

class setting_page extends StatefulWidget {
  @override
  State<setting_page> createState() => _setting_pageState();
}

class _setting_pageState extends State<setting_page> {
  String? lat, long, country, adminArea;
  @override
  void initState() {
    AppCubit.get(context).getUserData();
    super.initState();
    // getLocation();
  }

  var formKey = GlobalKey<FormState>();
  var nameEditController = TextEditingController();
  var emailEditController = TextEditingController();
  var phoneEditController = TextEditingController();
  var latEditController = TextEditingController();
  var longEditController = TextEditingController();
  var passwordEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        xBoneProfileModel? model = AppCubit.get(context).userModel;
        // xBoneRegisterModel? modellogin = xBoneRegisterCubit.get(context).RegisterModel;
        if (model != null) {
          nameEditController.text = model.data!.name!;
          emailEditController.text = model.data!.email!;
          latEditController.text = model.data!.lat!;
          longEditController.text = model.data!.long!;
          phoneEditController.text = model.data!.phone!;
        }
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                  "Settings",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      color: MyColors.myblack),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        modalBottomSheet(context);
                      },
                      child: Icon(
                        Icons.logout,
                        color: HexColor("#C11313"),
                        size: 25,
                      ),
                    ),
                  ),
                ]),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is xBoneLoadingUpdateUserDataState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Photo",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGreytext,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      if (state is ProfileUpdatePickedImageLoadingState)
                        CircularProgressIndicator(),
                      if (AppCubit.get(context).pickedImage != null &&
                          state is! ProfileUpdatePickedImageLoadingState)
                        CircleAvatar(
                          backgroundColor: HexColor("#004DC0"),
                          radius: 76,
                          child: CircleAvatar(
                            backgroundColor: MyColors.myWhite,
                            radius: 72,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  FileImage(AppCubit.get(context).image!),
                            ),
                          ),
                        ),
                      if (model!.data!.image != null &&
                          model.data!.image != "" &&
                          AppCubit.get(context).pickedImage == null &&
                          state is! ProfileUpdatePickedImageLoadingState)
                        CircleAvatar(
                          backgroundColor: HexColor("#004DC0"),
                          radius: 76,
                          child: CircleAvatar(
                            backgroundColor: MyColors.myWhite,
                            radius: 72,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(model.data!.image!),
                            ),
                          ),
                        ),

                      if (AppCubit.get(context).pickedImage == null &&
                          model.data!.image == null &&
                          state is! ProfileUpdatePickedImageLoadingState)
                        CircleAvatar(
                          backgroundColor: HexColor("#004DC0"),
                          radius: 76,
                          child: CircleAvatar(
                            backgroundColor: MyColors.myWhite,
                            radius: 72,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  AssetImage('assets/images/img.png'),
                            ),
                          ),
                        ),

                      Center(
                        child: TextButton(
                            onPressed: () {
                              AppCubit.get(context).uploadImage();
                            },
                            child: Text(
                              "Upload image",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#004DC0"),
                              ),
                            )),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 27,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 20,
                            child: TextFormField(
                              controller: nameEditController,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.black,
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
                              ),
                              decoration: InputDecoration(
                                  suffix: GestureDetector(
                                      onTap: () {
                                        nameEditController.clear();
                                      },
                                      child: const Icon(Icons.clear))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 20,
                            child: TextFormField(
                              controller: emailEditController,
                              textAlign: TextAlign.left,
                              cursorColor: HexColor("#747474"),
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
                              ),
                              decoration: InputDecoration(
                                  suffix: GestureDetector(
                                      onTap: () {
                                        emailEditController.clear();
                                      },
                                      child: Icon(Icons.clear))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Phone",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 26,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 20,
                            child: TextFormField(
                              controller: phoneEditController,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.black,
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
                              ),
                              decoration: InputDecoration(
                                  suffix: GestureDetector(
                                      onTap: () {
                                        phoneEditController.clear();
                                      },
                                      child: Icon(Icons.clear))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Location (Lat)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            height: 20,
                            child: TextFormField(
                              controller: latEditController,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.black,
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
                              ),
                              decoration: InputDecoration(
                                  // suffix: GestureDetector(
                                  //   onTap: () {
                                  //     locationEditController.clear();
                                  //   },
                                  //   child: InkWell(
                                  //     onTap: () {},
                                  //     child: Text(
                                  //       "Change",
                                  //       style: TextStyle(
                                  //         fontSize: 10,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: HexColor("#004DC0"),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Location (Long)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            height: 20,
                            child: TextFormField(
                              controller: longEditController,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.black,
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
                              ),
                              decoration: InputDecoration(
                                  // suffix: GestureDetector(
                                  //   onTap: () {
                                  //     locationEditController.clear();
                                  //   },
                                  //   child: InkWell(
                                  //     onTap: () {},
                                  //     child: Text(
                                  //       "Change",
                                  //       style: TextStyle(
                                  //         fontSize: 10,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: HexColor("#004DC0"),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      // Text("Country : ${country ??' Loading ...'}"),
                      // Text("Admin Area : ${adminArea ??' Loading ...'}"),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      if (state is xBoneLoadingUpdateUserDataState)
                        CircularProgressIndicator(),
                      if (state is! xBoneLoadingUpdateUserDataState)
                        Center(
                          child: Container(
                            width: 140.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: HexColor("#4482DE"),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextButton(
                              child: const Text(
                                "Save changes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    color: MyColors.myWhite),
                              ),
                              onPressed: () {
                                // AppCubit.get(context).getUserData();
                                // print(CacheHelper.getData(key: "name"));
                                // print(CacheHelper.getData(key: 'token'));
                                if (formKey.currentState!.validate()) {
                                  AppCubit.get(context).updateUserData(
                                    name: nameEditController.text,
                                    email: emailEditController.text,
                                    phone: phoneEditController.text,
                                    password: passwordEditController.text,
                                    lat: latEditController.text,
                                    long: longEditController.text,
                                    mainImage: model.data!.image!,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
//   void getLocation()async{
//     final service = LocationService();
//     final locationData = await service.getLocation();
//
//     if(locationData != null){
// final placeMark = await service.getPlacemark(locationData : locationData);
//       setState(() {
//         lat = locationData.latitude!.toStringAsFixed(2);
//         long = locationData.longitude!.toStringAsFixed(2);
//
//         country = placeMark?.country ?? 'could not get country';
//         adminArea = placeMark?.administrativeArea ?? 'could not get admin area';
//       });
//     }
//   }
}
