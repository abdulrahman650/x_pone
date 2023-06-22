
import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/controller/layout/home_layout.dart';
import 'package:x_pone/shared/bloc/login_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/login_cubit/states.dart';
import 'package:x_pone/shared/styles/colors.dart';
import '../../shared/componants/components.dart';
import '../../shared/network/remote/cache_helper.dart';
import '../Register/Register_design.dart';

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
              body: Stack(
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
                            SizedBox(
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
                                                const Text("Welcome Back ",
                                                  style: TextStyle(
                                                    fontSize:20,
                                                    fontWeight:FontWeight.w500,
                                                    color: MyColors.myblue,
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
                                                color: MyColors.myWhite,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: TextFormField(
                                                controller: emailController,
                                                keyboardType: TextInputType.text,
                                                validator: (value){
                                                  if (value!.isEmpty) {
                                                    return ' Email must not be empty';
                                                  }
                                                  return null;
                                                },
                                                decoration:   const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text('Email',
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
                                                color: MyColors.myWhite,
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
                                                }, validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return ' Password must not be empty';
                                                  }
                                                  return null;
                                                },
                                                obscureText: xBoneLoginCubit.get(context).isShown,
                                                decoration: InputDecoration(

                                                  border:  const OutlineInputBorder(),
                                                  label:  const Text('Password',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: MyColors.myGrey,
                                                    ),),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      xBoneLoginCubit.get(context)
                                                          .changePasswordVisibility();
                                                    },
                                                    icon:  const Icon(Icons.remove_red_eye,
                                                      color: MyColors.myGrey,
                                                    ),
                                                  ),
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
                                                    navigate2(context,const xpone_layout(),);}
                                                  );
                                                }else if(state is xBoneLoginErrorState){
                                                  if (kDebugMode) {
                                                    print(state.error);
                                                  }
                                                }
                                              },
                                              builder: (context, state){
                                                if(state is xBoneLoginLoadingState){
                                                  return const Center(child: CircularProgressIndicator());
                                                }
                                                return ConditionalBuilder(
                                                    condition: state is! xBoneLoginLoadingState,
                                                    builder: (BuildContext context){
                                                      return  Container(
                                                        decoration: BoxDecoration(
                                                          color: MyColors.myblue,
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
                                                            // AppCubit.get(context).getDoctorsModel();

                                                          },
                                                          child: const Text(
                                                            "Login",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14,color: MyColors.myWhite
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
                                                  child: const Text(
                                                    'Forgot Your password?',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color:         MyColors.myblue,

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
                                                  color: MyColors.myGrey,
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
                                                const Text(
                                                  'Or Sign Up',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 12,
                                                      color: MyColors.myGrey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Container(
                                                  // padding: const EdgeInsets.only(right: 8),
                                                  color: MyColors.myGrey,
                                                  child: const Divider(
                                                    height: .5,
                                                    thickness: 5,
                                                    indent: 20,
                                                    endIndent: 96,
                                                  ),
                                                ),

                                              ],
                                            ),
                                            const SizedBox(
                                              height: 25.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    'Don\'t have an account? ',
                                                    style: TextStyle(
                                                        color: MyColors.myGrey,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w300)
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    navigateTo(
                                                      context,
                                                      register_Screen(),
                                                    );

                                                  },
                                                  child: const Text(
                                                    'Sign Up',
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
                              // height: 43,
                              height: 120,
                            ),
                          ],

                        ),
                      ),

                    ),
                  )


                ],
              )

          );
        },

      ),
    );
  }
}


