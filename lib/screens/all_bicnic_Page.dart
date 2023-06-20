import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/models/doctors_model.dart';
import 'package:x_pone/screens/homePage.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';

import '../shared/componants/components.dart';
import 'details_clinics.dart';

class allClinicsPage extends StatelessWidget {
  allClinicsPage({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<DataDoctor>? doctorsModel = AppCubit.get(context).doctorList;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Clinics",
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
                  //         //     Navigator.pop(context);
                  //         //
                  //         //     // navigate2(context, homePage());
                  //         //   },
                  //         //   child: Icon(Icons.arrow_back_ios,
                  //         //     color: HexColor("#000000"),
                  //         //   ),
                  //         // ),
                  //         Text(
                  //           "Clinics",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 24.0,
                  //               color: HexColor("#000000")),
                  //         ),
                  //       ],
                  //     ),
                  //     // Text("Clinics",
                  //     //   style: TextStyle(
                  //     //     fontWeight: FontWeight.w600,
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
                      border:
                          Border.all(width: 0.5, color: HexColor("#FFFFFF")),
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
                          return ' clinics must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          'Search clinics',
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
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.filter_alt_sharp,
                        color: HexColor("#737373"),
                        size: 15,
                      ),
                      Text(
                        "sort by :",
                        style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#737373"),
                        ),
                      ),
                      Text(
                        " Location",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  state is xBoneLoadingDoctorsStates
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              detailsDocItem(context, doctorsModel![index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: 10,
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
    );
  }

  Widget detailsDocItem(context, DataDoctor model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              detailsClinics(
                model: model,
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: 161.0,
          decoration: BoxDecoration(
            color: HexColor("#004DC0"),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: HexColor("#0052CC").withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 9,
                offset: const Offset(0, 9), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 174,
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
                    child: Image.network(
                      model.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.19,
                child: Column(
                  children: [
                    Container(
                      height: 62,
                      decoration: BoxDecoration(
                        color: HexColor("#004DC0"),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.zero,
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
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
                              style: TextStyle(
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.w300,
                                  color: HexColor("#FFFFFF")),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 11,
                                    color: HexColor("#FBFF04"),
                                  ),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 11,
                                    color: HexColor("#FBFF04"),
                                  ),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 11,
                                    color: HexColor("#FBFF04"),
                                  ),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 11,
                                    color: HexColor("#FBFF04"),
                                  ),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 11,
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
                ),
              )
            ],
          ),
        ),
      );
}
