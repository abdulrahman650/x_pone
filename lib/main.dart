import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_pone/controller/layout/home_layout.dart';
import 'package:x_pone/screens/allbicnic2.dart';
import 'package:x_pone/screens/date.dart';

import 'package:x_pone/screens/home_Page.dart';

import 'package:x_pone/screens/rate_dr.dart';
import 'package:x_pone/screens/setting_Page.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';
import 'package:x_pone/shared/componants/components.dart';
import 'package:x_pone/shared/network/local/blocObserver.dart';
import 'package:x_pone/shared/network/local/dio_helper.dart';
import 'package:x_pone/shared/network/remote/cache_helper.dart';
import 'package:x_pone/shared/styles/themes.dart';

import 'controller/Register/Register_design.dart';
import 'controller/login/login_design.dart';
import 'on_boarding/logo_splash.dart';
import 'on_boarding/on_boarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  // print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = xpone_layout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const logo_splash();
  }
  runApp(MyApp(
    startWidget: widget,
    //    isDark: isDark,
  ));
}

class MyApp extends StatefulWidget {
  late final Widget startWidget;

  MyApp(
      // this.isDark,
      {required this.startWidget});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getArticles()
            ..getDoctorsModel()
          ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              // themeMode: AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark : ThemeMode.light,
              // theme: ThemeData(
              //     appBarTheme: AppBarTheme(
              //         systemOverlayStyle: SystemUiOverlayStyle(
              //             statusBarColor: Colors.white
              //         )
              //     )
              // ),
              home:
              // rateDoctor()
                  // logo_splash()
                  // setting_page()
                  // RegisterScreen()
                   widget.startWidget
                  // onBoarding ?
              // allClinicsPage2()
              //      LoginScreen()
              // : OnBoarding(),
              );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
