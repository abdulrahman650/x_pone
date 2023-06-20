// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/models/doctors_model.dart';
import 'package:x_pone/screens/allExercises_Page.dart';
import 'package:x_pone/screens/all_bicnic_Page.dart';
import 'package:x_pone/models/blogs_model.dart';
import 'package:x_pone/screens/details_clinics.dart';
import 'package:x_pone/screens/settingPage.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';
import 'package:x_pone/shared/componants/components.dart';

import '../models/blogs_model.dart';
import '../models/editProfile_model.dart';
import 'details_exercises.dart';

class homePage extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = currentDate
        .toString()
        .substring(0, 10); // Extracting only the date part
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        xBoneProfileModel? model = AppCubit.get(context).userModel;
        List<DataDoctor>? doctorsModel = AppCubit.get(context).doctorList;
        print(doctorsModel);
        return Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeBottom(3);
                        },
                        icon: Image.asset(
                          "assets/images/me.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Good Morning",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#737373"),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/hi.png",
                              width: 12,
                              height: 12,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${model?.data?.name}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#3D3D3D"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  height: 44.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: HexColor("#FFFFFF")),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
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
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      // SearchCubit.get(context).search(searchController.text);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Name must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        'Search doctors or clinics',
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
                  height: 45.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        "How is your joint hip\ntoday ?",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#3D3D3D"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9.0,
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#737373"),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best clinics",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#3D3D3D"),
                      ),
                    ),
                    const SizedBox(
                      width: 199.0,
                    ),
                    InkWell(
                      onTap: () {
                        // navigateTo(context, allClinicsPage());
                        AppCubit.get(context).changeBottom(2);
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0F57C3"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 161,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          detailsDocItem(context, doctorsModel![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 14.0,
                          ),
                      itemCount: 5),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Advices and routine",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#3D3D3D"),
                      ),
                    ),
                    const SizedBox(
                      width: 126.0,
                    ),
                    InkWell(
                      onTap: () {
                        // navigateTo(context, allExercisesPage());
                        AppCubit.get(context).changeBottom(1);
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0F57C3"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => detailsExcrciseItem(
                        context, AppCubit.get(context).articlesModel[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16.0,
                    ),
                    itemCount: AppCubit.get(context).articlesModel.length,
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        ));
      },
    );
  }

  Widget detailsDocItem(context, DataDoctor model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              detailsClinics(
                model: model,
              ));
          // return detailsDoctor();
        },
        child: Container(
          width: 312.0,
          height: 161.0,
          decoration: BoxDecoration(
            color: HexColor("#004DC0"),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: HexColor("#0052CC").withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 9,
                offset: const Offset(0, 9), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 151,
                height: 161.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.zero,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: borderRadius1,
                  child: SizedBox.fromSize(
                    // size: Size.fromRadius(10),
                    child: Image.network(
                      model.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 161,
                    height: 62,
                    decoration: BoxDecoration(
                      color: HexColor("#004DC0"),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name.toString(),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#FFFFFF")),
                          ),
                          Text(
                            "Orthopedics and joints specialist",
                            // model.address ?? '',
                            style: TextStyle(
                                fontSize: 8.0,
                                fontWeight: FontWeight.w300,
                                color: HexColor("#FFFFFF")),
                          ),
                          Container(
                            width: 161,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 10,
                                  color: HexColor("#FBFF04"),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                  color: HexColor("#FBFF04"),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                  color: HexColor("#FBFF04"),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                  color: HexColor("#FBFF04"),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    width: 161.0,
                    height: 62.0,
                    color: HexColor("#033E96"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 12,
                              color: HexColor("#DDE7F7"),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              model.address ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                  color: HexColor("#DDE7F7")),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: HexColor("#DDE7F7"),
                              size: 11,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              model.createdAt! ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8,
                                  color: HexColor("#DDE7F7"),

                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 12.0,
                              color: HexColor("#DDE7F7"),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "200 L.E / detection",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: HexColor("#DDE7F7"),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 161.0,
                    // width: MediaQuery.of(context).size.width,
                    height: 37.0,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      // color: HexColor("#004DC0"),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: TextButton(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 40.0,
                            ),
                            Text(
                              "contact",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#0052CC"),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/images/iconWatts.png",
                              width: 12,
                              height: 12,
                            ),
                          ],
                        ),
                        onPressed: () {}),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  Widget detailsExcrciseItem(context, DataBlog model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              detailsExercises(
                model: model,
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 215.0,
                  height: 113.0,
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
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(top: 11.0, left: 16),
                  child: Text(
                    model.content!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: HexColor("#FFFFFF"),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
