import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/doctors_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/componants/components.dart';
import 'details_clinics.dart';
import 'homePage.dart';

class detailsDoctor extends StatefulWidget {
  DoctorsModel? model;
   detailsDoctor({Key? key,required this.model}) : super(key: key);

  @override
  State<detailsDoctor> createState() => _detailsDoctorState();
}

class _detailsDoctorState extends State<detailsDoctor> {
  double showRating = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: 460.0,
                  width: double.infinity,
                  child: Image.asset(
                   AppCubit.get(context).doctorModel!.data!.image!,
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
                            Stack(children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // navigate2(context, detailsClinics());
                                },
                                child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor:
                                        HexColor("#737373").withOpacity(0.5),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 20,
                                      color: HexColor("#313131"),
                                    )),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 320.0,
                      ),
                      Container(
                        height: 720.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
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
                                  AppCubit.get(context).doctorModel!.data!.name!,
                                  // "Dr. Fadi Salah",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor("#000000"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Orthopedics and joints specialist",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("#737373"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 15.0,
                                      color: HexColor("737373"),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      AppCubit.get(context).doctorModel!.data!.address!,
                                      // "mansoura,elgesh st, after carfour mall, building 8",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: HexColor("#737373"),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 9.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 12.0,
                                      color: HexColor("737373"),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      AppCubit.get(context).doctorModel!.data!.createdAt!,
                                      // "every day, from 7pm to 10pm",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: HexColor("#737373"),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 15.0,
                                      color: HexColor("737373"),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      // AppCubit.get(context).doctorModel!.data!.!,
                                      "200 L.E / detection",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: HexColor("#737373"),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 11.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "4/5",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        color: HexColor("#000000"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: HexColor("#FDCB08"),
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: HexColor("#FDCB08"),
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: HexColor("#FDCB08"),
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: HexColor("#FDCB08"),
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: HexColor("#DADADA"),
                                      size: 16,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context)
                                              {
                                                return SizedBox(
                                                  height: 280,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            24.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Rate Dr. Fadi",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 22,
                                                                color: HexColor(
                                                                    "#000000"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child:
                                                              RatingBar.builder(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            initialRating:
                                                                showRating,
                                                            minRating: 1,
                                                            itemSize: 30,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        2),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              if (kDebugMode) {}
                                                              setState(() {
                                                                showRating =
                                                                    rating;
                                                                if (kDebugMode) {
                                                                  print(
                                                                      showRating);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 30.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                if (showRating <=
                                                                    4) {
                                                                  setState(() {
                                                                    showRating++;
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_back_ios_new,
                                                                color: HexColor(
                                                                    "#000000"),
                                                                size: 22.0,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 49.0),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "$showRating",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: HexColor(
                                                                        "#585858"),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "/5",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: HexColor(
                                                                        "#585858"),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                width: 49.0),
                                                            IconButton(
                                                              onPressed: () {
                                                                if (showRating >=
                                                                    1) {
                                                                  setState(() {
                                                                    showRating--;
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: HexColor(
                                                                    "#000000"),
                                                                size: 22.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 38.0,
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 44.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: HexColor(
                                                                "#004DC0"),
                                                          ),
                                                          child: TextButton(
                                                            onPressed: () {
                                                                Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              "Confirm",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: HexColor(
                                                                    "#FFFFFF"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          "Rate",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor("##004DC0"),
                                          ),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 29.0,
                                ),
                                Text(
                                  "About me",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("3D3D3D")),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("##737373"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 27.0,
                                ),
                                Text(
                                  "Certificates",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("3D3D3D")),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_hospital_outlined,
                                      size: 12.0,
                                      color: HexColor("737373"),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Lorem Ipsum is simply dummy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: HexColor("#737373"),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.house_siding_outlined,
                                      size: 12.0,
                                      color: HexColor("737373"),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Lorem Ipsum is simply dummy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: HexColor("#737373"),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 31.0,
                                ),
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("3D3D3D")),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 181.0,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: Image.asset(
                                    "assets/images/location_doc.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
