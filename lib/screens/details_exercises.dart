import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/models/blogs_model.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';
import 'package:x_pone/models/blogs_model.dart'as datamodel;
import '../shared/componants/components.dart';
import 'homePage.dart';

class detailsExercises extends StatelessWidget {
  ArticlesModel? model;
   detailsExercises({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,state){},
      builder: (context,state){

        return  Stack(
          children: [
            SizedBox(
              height: 420.0,
              width: double.infinity,
              child: Image.asset(
                "assets/images/exclamation.png",
                // model!.data!.image!
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 52.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                            children:[ TextButton(onPressed: (){
                              Navigator.pop(context);
                              // navigate2(context, homePage());

                            }, child:  CircleAvatar(
                                radius: 18,
                                backgroundColor: HexColor("#737373").withOpacity(0.5),
                                child: Icon(Icons.arrow_back_ios_new,
                                  size: 20,
                                  color: HexColor("#313131"),)),),
                            ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 270.0,
                  ),
                  // const SizedBox(
                  //   height: 374,
                  // ),
                  Container(
                    height: 610.0,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 34.0,
                            ),
                            Text(
                              ";IWHDLfsjhoiweHFI",
                             // model!.data!.title!,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#000000"),
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "jdlifWEJHFLAKRJGN",
                              // model!.data!.doctor!.name!,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#737373"),
                              ),
                            ),
                            Text(
                              ";ohwjdf;luiehwflik",
                             // model!.data!.createdAt!,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#737373"),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              ",MWLJfhkwrngl/",
                           // model!.data!.description!,


                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                                color: HexColor("#000000"),
                              ),
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ]
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },

    );
  }
}
