import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/controller/login/login_design.dart';

import '../bloc/app_cubit/cubit.dart';
import '../network/remote/cache_helper.dart';


void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future navigate2(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 12.0);
}


enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color= Colors.green;
      break;
    case ToastStates.warning:
      color= Colors.yellow;
      break;
    case ToastStates.error:
      color= Colors.red;
      break;
  }
  return color;
}

void printFulltext(String text){
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {debugPrint(element.group(0));});
  
}
final borderRadius2 = BorderRadius.circular(16);
const borderRadius1 =  BorderRadius.only(
  topLeft: Radius.circular(16),
  bottomLeft: Radius.circular(16),
  topRight: Radius.circular(16),
  bottomRight:   Radius.zero,

);


void signOut(context)
{
  CacheHelper.removeData( key: "token",).then((value) {
    if (value)
      {
        navigate2(context, LoginScreen());
      }
  });
}

modalBottomSheet(context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        // using a scaffold helps to more easily position the FAB
        return Container(
          height: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), topLeft: Radius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.maxFinite,
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "Logout",
                  // style: labelStyle2,
                ),
              ),
              const Divider(
                color: Colors.black,
                height: 5,
              ),
              const Text(
                "Are You Sure you want to logout? ",
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(CacheHelper.getData(key: 'token'));
                      }
                      CacheHelper.removeData(key:'token');
                      Navigator.pop(context);
                      token='';
                      if (kDebugMode) {
                        print(CacheHelper.getData(key: 'token'));
                      }
                    },child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  ),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(CacheHelper.getData( key: 'token').toString());
                      }
                      if (kDebugMode) {
                        print(token);
                      }
                      AppCubit.get(context).pageIndex= 0;
                      CacheHelper.removeData( key: 'token',).then((value){
                        if (value) {
                          navigate2(
                              context,
                              LoginScreen());
                        }
                        if (kDebugMode) {
                          print(CacheHelper.getDataList( key: 'token').toString());
                        }

                      });
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        color: HexColor("#4482DE"),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Center(
                        child: Text(
                          "Yes, Logout",
                          style: TextStyle(
                            color: HexColor("#DEDEDE"),
                          ),
                          // style: mediumStyle.copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // translate the FAB up by 30

          // dock it to the center top (from which it is translated)
        );
      });
}
String? token ='';

