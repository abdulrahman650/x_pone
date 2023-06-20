import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/models/blogs_model.dart';
import '../models/blogs_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/componants/components.dart';
import 'details_exercises.dart';
import 'homePage.dart';

class allExercisesPage extends StatelessWidget {
  allExercisesPage({
    Key? key,
  }) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(AppCubit.get(context).articlesModel);
    print('articaaaaaaaaaaaaaaaaaaaaaaaaaaaaal');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<DataBlog>? articlesModel = AppCubit.get(context).articlesModel;
          return ConditionalBuilder(
            condition: state is! xBoneLoadingArticlesStates,
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Articles",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                        color: HexColor("#000000")),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // const SizedBox(height: 31.0,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         // InkWell(
                        //         //   onTap:(){
                        //         //
                        //         //     Navigator.pop(context);
                        //         //     // navigate2(context, homePage());
                        //         //   },
                        //         //   child: Icon(Icons.arrow_back_ios,
                        //         //     color: HexColor("#000000"),
                        //         //   ),
                        //         // ),
                        //         Text(
                        //           "Articles",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 24.0,
                        //               color: HexColor("#000000")),
                        //         ),
                        //       ],
                        //     ),
                        //     // Text("Articles",
                        //     //   style: TextStyle(
                        //     //       fontWeight: FontWeight.w600,
                        //     //       fontSize: 24.0,
                        //     //       color: HexColor("#000000")
                        //     //   ),),
                        //   ],
                        // ),
                        // const SizedBox(height: 35.0,),
                        Container(
                          width: double.infinity,
                          height: 44.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: HexColor("#FFFFFF")),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: HexColor("#0052CC").withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 9,
                                offset: const Offset(
                                    0, 9), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (value) {
                              // SearchCubit.get(context).search(searchController.text);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' orticles must not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Text(
                                'Search orticles',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: HexColor("#94A3B8"),
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: HexColor("#94A3B8"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => detailsExcrciseItem(
                              context, articlesModel[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: articlesModel.length,
                        ),
                        const SizedBox(
                          height: 100.0,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget detailsExcrciseItem(context, DataBlog model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              detailsExercises(
                model: model,
              ));
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 127.0,
                  decoration: BoxDecoration(
                    color: HexColor("#004DC0"),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#0052CC").withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 9,
                        offset:
                            const Offset(0, 9), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius2,
                    child: SizedBox.fromSize(
                      // size: Size.fromRadius(10),
                      child: Image.network(
                        model.image!,
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(.8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11.0, left: 16),
                  child: Text(
                    model.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: HexColor("#FFFFFF"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
