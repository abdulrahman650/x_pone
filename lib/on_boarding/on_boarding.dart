import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../controller/login/login_design.dart';
import '../shared/componants/components.dart';
import '../shared/network/remote/cache_helper.dart';
import '../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}
class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onb1.png',
      title: 'Getting Advice',
      body: ' Easily read blogs about joint hip and \n what to do after surgery for quick recovery',
    ),
    BoardingModel(
      image: 'assets/images/onb2.png',
      title: 'Filter Doctors',
      body: 'Search orthopedic clinics and filter results \n for The most appropriate and nearest one',
    ),
    BoardingModel(
      image: 'assets/images/onb3.png',
      title: 'Getting Advice',
      body: "Easily read blogs about joint hip and \n what to do after surgery for quick recovery",
    ),
  ];

  var boardController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveLoginData('onBoarding', true).then((value) {
     if(value){
       navigate2(
         context,
         LoginScreen(),
       );
     }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              top: 20.0,
            ),
            child: SizedBox(
              width: 78,
              height: 40,
              child: TextButton(
                onPressed: () {
                  submit();
                  setState(() {});
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(color: MyColors.myGrey),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: MyColors.myGrey,
                    activeDotColor: MyColors.myblue,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  count: boarding.length,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                scrollBehavior: const ScrollBehavior(),
                itemBuilder: (context, index) {
                  return buildBoardingItem(boarding[index]);
                },
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: boarding.length, //required parameter
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 78,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      }
                      else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastOutSlowIn

                        );
                      }

                    },
                    child: Text(
                      isLast ? "Start" : 'Next'.toUpperCase(),
                      style: const TextStyle(
                        color: MyColors.myWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            model.title,
            style: const TextStyle(
              color: MyColors.myblue,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Center(
          child: Text(
            model.body,
            style: const TextStyle(
              fontSize: 16.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
      ],
    );
  }
}
