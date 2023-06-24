import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';


import '../../screens/home_Page.dart';
import '../../screens/location.dart';
import '../../shared/bloc/app_cubit/cubit.dart';
import '../../shared/bloc/register_cubit/cubit.dart';
import '../../shared/bloc/register_cubit/states.dart';
import '../../shared/componants/components.dart';
import '../../shared/network/remote/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../layout/home_layout.dart';
import '../login/login_design.dart';

class register_Screen extends StatefulWidget {
  register_Screen({Key? key}) : super(key: key);

  @override
  State<register_Screen> createState() => _register_ScreenState();
}

class _register_ScreenState extends State<register_Screen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String? country, adminArea;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => xBoneRegisterCubit(),
      child: BlocConsumer<xBoneRegisterCubit, xBoneRegisterStates>(
        listener: (context, state) {
          if (state is xBoneRegisterSuccessState) {
            CacheHelper.saveLoginData('token', state.RegisterModel.data)
                .then((value) {
              token = state.RegisterModel.data;
              navigate2(
                context,
                const xpone_layout(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(35.0),
                                        child: InkWell(
                                          onTap: () {
                                            navigateTo(
                                              context,
                                              LoginScreen(),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            color: MyColors.myGreytext,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 560,
                                        child: Image.asset(
                                          "assets/images/picdocinlogin.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 550,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 4.0, sigmaY: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 79,
                                                height: 20,
                                                child: Image.asset(
                                                    "assets/images/Signin.png"),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20.0),
                                          Container(
                                            height: 44.0,
                                            decoration: BoxDecoration(
                                              color: MyColors.myWhite,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            // color: Colors.white,
                                            child: TextFormField(
                                              controller: emailController,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return ' Email must not be empty';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: Text(
                                                  'Email',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.myGrey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            height: 44.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: TextFormField(
                                              controller: phoneController,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return ' phone must not be empty';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: Text(
                                                  'Your Phone',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: MyColors.myGrey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            height: 44.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: TextFormField(
                                              controller: nameController,
                                              keyboardType: TextInputType.name,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return ' Name must not be empty';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: Text(
                                                  'Your Name',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.myGrey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            height: 44.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: TextFormField(
                                              controller: passwordController,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              onFieldSubmitted: (value) {},
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return ' Password must not be empty';
                                                }
                                                return null;
                                              },
                                              obscureText: xBoneRegisterCubit
                                                  .get(context)
                                                  .isShown,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: const Text(
                                                  'Password',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.myGrey,
                                                  ),
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    xBoneRegisterCubit
                                                        .get(context)
                                                        .changePasswordVisibility();
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_red_eye,
                                                    color: MyColors.myGrey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: MyColors.myGrey,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            width: double.infinity,
                                            height: 40,
                                            child: TextButton(
                                              onPressed: () {
                                                calculateDistance();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text(
                                                    "Your Location",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: MyColors.myWhite,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: MyColors.myWhite,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Click to select your location",
                                                style: TextStyle(
                                                    color: MyColors.myblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15.0,
                                          ),
                                          ConditionalBuilder(
                                            condition: state
                                                is! xBoneRegisterLoadingState,
                                            builder: (BuildContext context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: HexColor("#0F57C3"),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                width: double.infinity,
                                                height: 40,
                                                child: TextButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      xBoneRegisterCubit
                                                          .get(context)
                                                          .userRegister(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            name: nameController
                                                                .text,
                                                            phone:
                                                                phoneController
                                                                    .text,
                                                            long: "15.5",
                                                            lat: "15.5",
                                                          );
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Sign up",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: MyColors.myWhite,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            fallback: (BuildContext context) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          ),
                                          const SizedBox(
                                            height: 11.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  'Forgot Your password?',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.myblue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: MyColors.myGrey,
                                                child: const Divider(
                                                  height: .5,
                                                  thickness: 5,
                                                  indent: 20,
                                                  endIndent: 90,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 9.0,
                                              ),
                                              const Text(
                                                'Have account ?',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                  color: MyColors.myGrey,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 9.0,
                                              ),
                                              Container(
                                                color: MyColors.myGrey,
                                                child: const Divider(
                                                  height: .5,
                                                  thickness: 5,
                                                  indent: 20,
                                                  endIndent: 80,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                  'Already have an account? ',
                                                  style: TextStyle(
                                                      color: MyColors.myGrey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              InkWell(
                                                onTap: () {
                                                  navigateTo(
                                                    context,
                                                    LoginScreen(),
                                                  );
                                                },
                                                child: const Text(
                                                  'Login',
                                                  style: TextStyle(
                                                    color: MyColors.myblue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void calculateDistance() async {
    LocationData position = await Location.instance.getLocation();

    double latitude = position.latitude!;
    double longitude = position.longitude!;
    print(latitude);
    print(longitude);
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      final placeMark = await service.getPlacemark(locationData: locationData);
      setState(() {
        // lat = locationData.latitude!.toStringAsFixed(2);
        // long = locationData.longitude!.toStringAsFixed(2);

        country = placeMark?.country ?? 'could not get country';
        adminArea = placeMark?.administrativeArea ?? 'could not get admin area';

        LocationController.instance.setLocation('$country - $adminArea');
      });
    }
  }
}

class LocationController {
  LocationController._();

  static LocationController instance = LocationController._();

  String location = '';

  void setLocation(String newLocation) {
    location = newLocation;
  }
}
