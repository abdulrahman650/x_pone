import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/models/blogs_model.dart';
import 'package:x_pone/shared/styles/colors.dart';
import '../models/blogs_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/componants/components.dart';
import 'details_exercises.dart';
import 'home_Page.dart';

class allExercisesPage extends StatefulWidget {
  allExercisesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<allExercisesPage> createState() => _allExercisesPageState();
}

class _allExercisesPageState extends State<allExercisesPage> {
  List<DataBlog>? allBlogs;

  List<DataBlog>? searchedForBlogs;

  bool _isSearching = false;

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
                        Container(
                          width: double.infinity,
                          height: 44.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: MyColors.myWhite,),
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
                            onChanged: (searchblogs){
                              addSearchedFOrItemsToSearchedList(searchblogs);

                            },
                            onFieldSubmitted: (value) {
                              // SearchCubit.get(context).search(searchController.text);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' orticles must not be empty';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                'Search orticles',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: MyColors.myGrey,
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color:MyColors.myGrey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      state is xBoneLoadingArticlesStates
                      ? const Center(
                      child: CircularProgressIndicator(),
                ):
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                          detailsExcrciseItem(context, searchController.text.isEmpty? articlesModel[index]: searchedForBlogs![index]),

                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: searchController.text.isEmpty? articlesModel.length : searchedForBlogs!.length,

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
                      child:
                      model.image!.isNotEmpty
                          ? FadeInImage.assetNetwork(
                        placeholder: "assets/images/loading.gif",
                        image: model.image!,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        "assets/images/pic_exc.png",
                        fit: BoxFit.cover,
                      )
                      // Image.network(
                      //   model.image!,
                      //   fit: BoxFit.cover,
                      //   opacity: const AlwaysStoppedAnimation(.8),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11.0, left: 16),
                  child: Text(
                    model.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color:MyColors.myWhite,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  void addSearchedFOrItemsToSearchedList(String searchedBlogs) {
    searchedForBlogs= AppCubit.get(context).articlesModel
        .where((character) =>
        character.title!.toLowerCase().startsWith(searchedBlogs))
        .toList();
    setState((){});
  }
}
