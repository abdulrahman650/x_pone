
import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/controller/layout/home_layout.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/login_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/login_cubit/states.dart';

import '../../screens/homePage.dart';
import '../../shared/componants/components.dart';
import '../../shared/network/remote/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../Register/Register_design.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => xBoneLoginCubit() ,
      child: Builder(

        builder: (context){
          final cubit= xBoneLoginCubit.get(context);
          return  Scaffold(
              body:
              Container(
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 590,
                              child:
                              Image.asset("assets/images/picdocinlogin.png"),
                            ),
                          ],
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
                                // height: 480,
                                height: 380,
                                child: ClipRect(
                                  child:  BackdropFilter(
                                    filter:  ImageFilter.blur(sigmaX: 4.0, sigmaY: 10.0),
                                    child:  Container(
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Colors.grey.shade200.withOpacity(0.5)
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Welcome Back ",
                                                    style: TextStyle(
                                                      fontSize:20,
                                                      fontWeight:FontWeight.w500,
                                                      color: HexColor("#0F57C3"),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child:
                                                    Image.asset("assets/images/hi.png"),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20.0),
                                              Container(
                                                height: 44.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                // color: Colors.white,
                                                child: TextFormField(
                                                  controller: emailController,
                                                  keyboardType: TextInputType.text,
                                                  validator: (value){
                                                    if (value!.isEmpty) {
                                                      return ' Email must not be empty';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:   InputDecoration(
                                                    border: const OutlineInputBorder(),
                                                    label: Text('Email',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: HexColor("#94A3B8"),

                                                      ),
                                                    ),
                                                    // prefixIcon:  Icon(
                                                    //   Icons.email_outlined,
                                                    //   color: HexColor("#94A3B8"),
                                                    // ),
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
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: TextFormField(
                                                  controller: passwordController,
                                                  keyboardType: TextInputType.visiblePassword,
                                                  onFieldSubmitted: (value) {
                                                    if(formKey.currentState!.validate()){
                                                      xBoneLoginCubit.get(context).userLogin(
                                                        context: context,
                                                        email: emailController.text,
                                                        password: passwordController.text,
                                                      );
                                                    }
                                                  },


                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return ' Password must not be empty';
                                                    }
                                                    return null;
                                                  },
                                                  obscureText: xBoneLoginCubit.get(context).isShown,
                                                  decoration: InputDecoration(

                                                    border:  OutlineInputBorder(),
                                                    label:  Text('Password',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: HexColor("#94A3B8"),
                                                      ),),

                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        xBoneLoginCubit.get(context)
                                                            .changePasswordVisibility();
                                                      },
                                                      icon:  Icon(Icons.remove_red_eye,
                                                        color: HexColor("#94A3B8"),
                                                        // xBoneLoginCubit.get(context).iconData,
                                                      ),
                                                    ),
                                                    // prefixIcon:  Icon(
                                                    //   Icons.lock_rounded,
                                                    //   color: HexColor("#94A3B8"),
                                                    // ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              BlocConsumer<xBoneLoginCubit, xBoneLoginState>(
                                                listener: (context , state){
                                                  if(state is xBoneLoginSuccessState)
                                                  {
                                                    CacheHelper.saveLoginData(
                                                        'token',
                                                        state.loginModel.data?.accessToken ).then((value)
                                                    {
                                                      token = state.loginModel.data?.accessToken;
                                                      navigate2(context,XponeLayout(),);
                                                    }
                                                    );
                                                  }else if(state is xBoneLoginErrorState){
                                                    print(state.error);

                                                  }
                                                },
                                                builder: (context, state){
                                                  if(state is xBoneLoginLoadingState){
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                  return ConditionalBuilder(
                                                      condition: state is! xBoneLoginLoadingState,
                                                      builder: (BuildContext context){
                                                        return  Container(
                                                          decoration: BoxDecoration(
                                                            color: HexColor("#0F57C3"),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          width: double.infinity,
                                                          height: 40,
                                                          child: TextButton(
                                                            onPressed: (){

                                                              if(formKey.currentState!.validate()){
                                                                cubit.userLogin(
                                                                  context: context,
                                                                  email: emailController.text,
                                                                  password: passwordController.text,
                                                                );
                                                              }


                                                            },
                                                            child: const Text(
                                                              "Login",
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14,color: Colors.white
                                                              ),),
                                                          ),
                                                        );
                                                      },
                                                      fallback: (BuildContext context){
                                                        return const Center(
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      }
                                                  );
                                                },


                                              ),
                                              const SizedBox(
                                                height: 11.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Forgot Your password?',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: HexColor("#0F57C3")
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:  [
                                                  Container(
                                                    color: HexColor("#696969"),
                                                    child: const Divider(
                                                      height: .5,
                                                      thickness: 5,
                                                      indent: 20,
                                                      endIndent: 110,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    'Or Sign Up',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 12,
                                                        color: HexColor("#696969")
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Container(
                                                    // padding: const EdgeInsets.only(right: 8),
                                                    color: HexColor("#696969"),
                                                    child: const Divider(
                                                      height: .5,
                                                      thickness: 5,
                                                      indent: 20,
                                                      endIndent: 96,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              // const SizedBox(
                                              //   height: 25.0,
                                              // ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              //
                                              //   children: [
                                              //     Expanded(
                                              //       child: Container(
                                              //         decoration: BoxDecoration(
                                              //             borderRadius: BorderRadius.circular(8),
                                              //             border: Border.all(color: HexColor("#0F57C3"))
                                              //         ),
                                              //         height:40,
                                              //         width: 142,
                                              //         child: TextButton(
                                              //           onPressed:(){} ,
                                              //           child:Row(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             children: [
                                              //               Container(
                                              //                 width: 15.45,
                                              //                 height: 16,
                                              //                 child: Image.asset("assets/images/face.png"),
                                              //               ),
                                              //               const SizedBox(
                                              //                 width: 10.0,
                                              //               ),
                                              //               Container(
                                              //                   width: 59,
                                              //                   height: 20,
                                              //                   child: Image.asset("assets/images/facepic.png")
                                              //                 // Text(
                                              //                 //   'facebook',
                                              //                 //   style: TextStyle(
                                              //                 //       fontWeight: FontWeight.w400,
                                              //                 //       fontSize: 13,
                                              //                 //       color: HexColor("#0F57C3")
                                              //                 //   ),
                                              //                 // ),
                                              //               ),
                                              //             ],
                                              //           ) ,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     const SizedBox(
                                              //       width: 15.0,
                                              //     ),
                                              //     Expanded(
                                              //       child: Container(
                                              //         decoration: BoxDecoration(
                                              //             borderRadius: BorderRadius.circular(8),
                                              //             border: Border.all(color: HexColor("#0F57C3"))
                                              //         ),
                                              //         height:40,
                                              //         width: 142,
                                              //         child: TextButton(
                                              //           onPressed:(){} ,
                                              //           child:Row(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             children: [
                                              //               Container(
                                              //                 width: 15.45,
                                              //                 height: 16,
                                              //                 child: Image.asset("assets/images/chrome.png"),
                                              //               ),
                                              //               const SizedBox(
                                              //                 width: 10.0,
                                              //               ),
                                              //               Container(
                                              //                   width: 44.0,
                                              //                   height: 20,
                                              //                   child:Image.asset("assets/images/chromet.png")
                                              //                 // Text(
                                              //                 //   'google',
                                              //                 //   style: TextStyle(
                                              //                 //       fontWeight: FontWeight.w300,
                                              //                 //       fontSize: 14,
                                              //                 //       color: HexColor("#0F57C3")
                                              //                 //   ),
                                              //                 // ),
                                              //               ),
                                              //             ],
                                              //           ) ,
                                              //         ),
                                              //       ),
                                              //     )
                                              //   ],
                                              // ),
                                              const SizedBox(
                                                height: 25.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'Don\'t have an account? ',
                                                      style: TextStyle(
                                                          color: HexColor("#696969"),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w300)
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateTo(
                                                        context,
                                                        RegisterScreen(),
                                                      );

                                                    },
                                                    child: Text(
                                                      'Sign Up',
                                                      style: TextStyle(
                                                        color: HexColor("#0F57C3"),
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
                                // height: 43,
                                height: 120,
                              ),
                            ],

                          ),
                        ),

                      ),
                    )


                  ],
                ),
              )

          );
        },

      ),
    );
  }
}


