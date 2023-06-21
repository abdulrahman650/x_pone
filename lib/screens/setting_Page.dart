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
  void initState(){
    super.initState();
    // getLocation();
  }
  var formKey =GlobalKey<FormState>();
  var nameEditController = TextEditingController();
  var emailEditController = TextEditingController();
  var phoneEditController = TextEditingController();
  var locationEditController = TextEditingController();
  var passwordEditController = TextEditingController();


  @override
  Widget build(BuildContext context) {
        return BlocConsumer<AppCubit , AppStates>(
          listener: (context, state)
          {},
          builder: (context, state)
          {
            xBoneProfileModel? model =AppCubit.get(context).userModel;
            // xBoneRegisterModel? modellogin = xBoneRegisterCubit.get(context).RegisterModel;
            nameEditController.text = "${model?.data?.name}";
            emailEditController.text = "${model?.data?.email}";
            // passwordEditController.text = "${model?.data?.}";
             // passwordEditController.text = '${modellogin?.data?.password}';
            // locationEditController.text = model.data!.location!;
            phoneEditController.text = "${model?.data?.phone}";
            return Scaffold(
                appBar:AppBar(
                    title:
                    const Text(
                      "Settings",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0,
                          color: MyColors.myblack),
                    ),
                    actions:[
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
                    ]

                ),
                body: SingleChildScrollView(
                  child: ConditionalBuilder(
                      condition: AppCubit.get(context).userModel != null,
                      builder: (context)=> Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              if(state is xBoneLoadingUpdateUserDataState)
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
                              CircleAvatar(
                                backgroundColor: HexColor("#004DC0"),
                                radius: 76,
                                child: const CircleAvatar(
                                  backgroundColor: MyColors.myWhite,
                                  radius: 72,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: AssetImage('assets/images/img.png'),
                                  ),
                                ),
                              ),
                              Center(
                                child: TextButton(
                                    onPressed: () {},
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

                                    width: MediaQuery.of(context).size.width /1.4,
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
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor("#747474"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /1.4,
                                    height: 20,
                                    child: TextFormField(
                                      controller: emailEditController,
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      onChanged: (value) {},
                                      style: const TextStyle(
                                        color: MyColors.myGrey,
                                      ),
                                      decoration: InputDecoration(

                                        // labelText: 'First Name',
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
                                    width: MediaQuery.of(context).size.width /1.4,
                                    height: 20,
                                    child: TextFormField(
                                      controller: phoneEditController,
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      onChanged: (value) {},
                                      style: const TextStyle(
                                        color:MyColors.myGrey,
                                      ),
                                      decoration: InputDecoration(

                                        // labelText: 'First Name',
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
                                    "Location",
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
                                    width: MediaQuery.of(context).size.width /1.4,
                                    height: 20,
                                    child: TextFormField(
                                      controller: locationEditController,
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      onChanged: (value) {},
                                      style: const TextStyle(
                                        color: MyColors.myGrey,
                                      ),
                                      decoration: InputDecoration(
                                        suffix:
                                        GestureDetector(
                                          onTap: () {
                                            locationEditController.clear();
                                          },
                                          child:
                                          InkWell(
                                            onTap: () {},
                                            child: Text(
                                              "Change",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: HexColor("#004DC0"),
                                              ),
                                            ),
                                          ),
                                        ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:MyColors.myGrey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.4,
                                    height: 25,
                                    child: TextFormField(
                                      controller: passwordEditController,
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.black,
                                      onChanged: (value) {},
                                      style: const TextStyle(
                                        color: MyColors.myGrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Container(
                                  width: 130.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: HexColor("#4482DE"),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      "Save changes",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        color: HexColor("#DEDEDE"),
                                      ),
                                    ),
                                    onPressed: () {
                                   print(CacheHelper.getData(key: "name"));
                                      if(formKey.currentState!.validate())
                                        {
                                          AppCubit.get(context).updateUserData(
                                            name: nameEditController.text,
                                            email: emailEditController.text,
                                            phone: phoneEditController.text,
                                            password: passwordEditController.text,
                                            lat: "",
                                            long: "",
                                            image: "",
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
                      fallback: (context) => const Center(child: CircularProgressIndicator())
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
