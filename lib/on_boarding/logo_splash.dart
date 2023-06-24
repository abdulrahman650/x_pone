import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../shared/componants/components.dart';
import 'on_boarding.dart';

class logo_splash extends StatefulWidget {
  const logo_splash({Key? key}) : super(key: key);

  @override
  State<logo_splash> createState() => _logo_splashState();
}

class _logo_splashState extends State<logo_splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Test();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 190,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 131,
                width:54,
                child: Image.asset("assets/images/side1inhome.png"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 223,
                width:153,
                child: Image.asset("assets/images/logohome.png"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.end,
            children: [
              Container(
                alignment: AlignmentDirectional.bottomEnd,

                height: 131,
                width:54,
                child: Image.asset("assets/images/sidein2page.png"),
              ),
            ],
          ),
        ],
      ),


    );
  }
  void Test(){
    Timer(const Duration(seconds: 4),
            (){
      navigate2(context, const OnBoarding());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  OnBoarding()),
          // );
        }
    );
  }
}
