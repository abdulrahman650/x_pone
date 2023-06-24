import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../controller/Register/Register_design.dart';
import '../controller/login/login_design.dart';
import '../models/Register_model.dart';
import '../models/editProfile_model.dart';
import '../models/login_model.dart';
import '../models/profile_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/componants/components.dart';
import '../shared/network/remote/cache_helper.dart';
import '../shared/styles/colors.dart';
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
  }

  var formKey = GlobalKey<FormState>();
  var nameEditController = TextEditingController();
  var emailEditController = TextEditingController();
  var phoneEditController = TextEditingController();
  var latEditController = TextEditingController();
  var longEditController = TextEditingController();
  var passwordEditController = TextEditingController();
  var locationEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        xBoneProfileModel? model = AppCubit.get(context).userModel;
        // xBoneRegisterModel? modellogin = xBoneRegisterCubit.get(context).RegisterModel;
        if (model != null) {
          nameEditController.text = model.data?.name ?? '';
          emailEditController.text = model.data?.email ?? '';
          latEditController.text = model.data?.lat?? '';
          longEditController.text = model.data?.long?? '';
          phoneEditController.text = model.data?.phone?? '';
          passwordEditController.text = "123123123";
          locationEditController.text = ":${LocationController.instance.location}";

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
                      if (state is ProfileUpdatePickedImageLoadingState)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: LinearProgressIndicator(),
                        ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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

                      if (
                          AppCubit.get(context).image != null)
                        CircleAvatar(
                          backgroundColor: HexColor("#004DC0"),
                          radius: 76,
                          child: CircleAvatar(
                            backgroundColor: MyColors.myWhite,
                            radius: 72,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(AppCubit.get(context).image!),
                            ),
                          ),
                        ),

                      if (AppCubit.get(context).image == null &&
                          state is! ProfileUpdatePickedImageLoadingState)
                        CircleAvatar(
                          backgroundColor: HexColor("#004DC0"),
                          radius: 76,
                          child: const CircleAvatar(
                            backgroundColor: MyColors.myWhite,
                            radius: 72,
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/images/imageprofile.png'),    radius: 70,

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
                            "Password",
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
                            width: MediaQuery.of(context).size.width / 1.45,
                            height: 20,
                            child: TextFormField(
                              controller: passwordEditController,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.black,
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
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
                            "location",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.myGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.45,
                            height: 20,
                            child: TextFormField(
                              controller: locationEditController,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.black,
                              onChanged: (value) {},
                              style: TextStyle(
                                color: HexColor("#747474"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // Text("Country : ${{LocationController.instance.location} ??' Loading ...'}"),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      // const SizedBox(
                      //   height: 40,
                      // ),

                      if (state is xBoneLoadingUpdateUserDataState)
                        const CircularProgressIndicator(),
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
                                if (formKey.currentState!.validate()) {
                                  AppCubit.get(context).updateUserData(
                                    name: nameEditController.text,
                                    email: emailEditController.text,
                                    phone: phoneEditController.text,
                                    password: passwordEditController.text,
                                    lat: latEditController.text,
                                    long: longEditController.text,
                                    mainImage: AppCubit.get(context).image!.path,
                                  );
                                }
                              },
                            ),

                          ),
                        ),
                       const SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

}
