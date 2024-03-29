import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';


import '../models/doctors_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/styles/colors.dart';

class detailsClinics extends StatefulWidget {

   detailsClinics({Key? key ,required this.model}) : super(key: key);
   final DataDoctor? model;
  @override
  State<detailsClinics> createState() => _detailsClinicsState();
}

class _detailsClinicsState extends State<detailsClinics> {

  double showRating = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <AppCubit , AppStates>(
      listener: (context, state){},
      builder: (context, state){
        // List<DataDoctor>? doctorsModel = AppCubit.get(context).doctorList;

        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child:   Container(
              color: Colors.transparent,
              child:   InkWell(
                onTap: () {
                  openWhatsApp(widget.model!.phone);
                },
                child: Container(
                  width: double.infinity,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: HexColor("#004DC0"),
                    // color: HexColor("#004DC0"),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "contact",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#FEFEFE"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/iconWatts.png",
                        width: 12,
                        color: HexColor("#FEFEFE"),
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: 400.0,
                width: double.infinity,
                child:
                widget.model!.image!.isNotEmpty
                    ? FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",
                  image:widget.model!.image!,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  "assets/images/3yada.png",
                  fit: BoxFit.cover,
                )
              ),
              SingleChildScrollView(
                child: Column(

                  children: [
                    const SizedBox(
                      height: 52.0,
                    ),
                     Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                              children:[
                                TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child:  CircleAvatar(
                                  radius: 18,
                                  backgroundColor: MyColors.mydarkgray.withOpacity(0.5),
                                  child: Icon(Icons.arrow_back_ios_new,
                                    size: 20,
                                    color: HexColor("#313131"),)),),
                              ]),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 300.0,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 750.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color:MyColors.myWhite,
                          borderRadius: BorderRadius.only(
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
                                Row(
                                  children: [
                                    Text(
                                      widget.model!.name.toString()  ??'',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                                  const SizedBox(
                                      width: 8.0,
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Text(
                                  "Orthopedics and joints specialist",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: MyColors.mydarkgray,
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 15.0,
                                      color: MyColors.myGreytext,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      widget.model!.address??'',

                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: MyColors.myGreytext,
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
                                    const Icon(
                                      Icons.access_time,
                                      size: 12.0,
                                      color: MyColors.myGreytext,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    if(widget.model!.workingHours!.start != null && widget.model!.workingHours!.end != null)
                                      Text(
                                        // widget.model!.createdAt??'',
                                        widget.model!.workingHours!.start! +" / " +widget.model!.workingHours!.end!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: MyColors.myGreytext,

                                        ),
                                      ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.attach_money,
                                      size: 15.0,
                                      color: MyColors.myGreytext,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    if (widget.model!.price != null)
                                      Text(
                                        widget.model!.price.toString()+"LE/EGP",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: MyColors.myGreytext,
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
                                    const Text(
                                      "4/5",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        color: MyColors.myblack
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: MyColors.myYellow,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: MyColors.myYellow,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: MyColors.myYellow,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      height: 2.9,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: MyColors.myYellow,
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
                                                return modelRateBottomSheet();
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
                                  height: 20.0,

                                ),
                                Text(
                                  "Services",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("3D3D3D")),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                              if (widget.model!.services != null)
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: List.generate(
                                        widget.model!.services!.length,
                                        (index) => Container(
                                          margin:
                                              EdgeInsetsDirectional.only(end: 5),
                                          padding: EdgeInsetsDirectional.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(16),
                                            ),
                                            color: HexColor("#E8F1FF"),
                                          ),
                                          child: Center(
                                            child: Text(
                                              widget.model!.services![index],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor("#0046AF"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ),const SizedBox(
                                  height: 18.0,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     openWhatsApp(widget.model!.phone);
                                //   },
                                //   child: Container(
                                //     width: double.infinity,
                                //     height: 44.0,
                                //     decoration: BoxDecoration(
                                //       color: HexColor("#004DC0"),
                                //       // color: HexColor("#004DC0"),
                                //       borderRadius:
                                //       const BorderRadius.all(Radius.circular(8)),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Text(
                                //           "contact",
                                //           style: TextStyle(
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.w400,
                                //             color: HexColor("#FEFEFE"),
                                //           ),
                                //         ),
                                //         const SizedBox(
                                //           width: 10,
                                //         ),
                                //         Image.asset(
                                //           "assets/images/iconWatts.png",
                                //           width: 12,
                                //           color: HexColor("#FEFEFE"),
                                //           height: 12,
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  "About me",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.mydarkgray),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                 Text(
                                  widget.model!.notes ?? "No data",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: MyColors.myGreytext,
                                  ),
                                ),
                                const SizedBox(
                                  height: 22.0,
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
                                    const Icon(
                                      Icons.local_hospital_outlined,
                                      size: 12.0,
                                      color:  MyColors.myGreytext,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        widget.model!.education ?? "No data",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color:  MyColors.myGreytext,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.mydarkgray),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 181.0,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  child: Image.asset(
                                    "assets/images/location_doc.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ]),

                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      },

    );
  }

  void openWhatsApp(phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
  void openFacebook() async {
    String url = 'https://www.facebook.com/';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  SizedBox modelRateBottomSheet(){
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
              children:  [
                const Text(
                  "Rate - ",
                  style: TextStyle(
                    fontWeight:
                    FontWeight
                        .w500,
                    fontSize: 22,
                    color: MyColors.myblack,
                  ),
                ),
                Text(
                  widget.model!.name??'',
                  style: const TextStyle(
                    fontWeight:
                    FontWeight
                        .w500,
                    fontSize: 22,
                    color: MyColors.myblack,
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
                  icon: const Icon(
                    Icons
                        .arrow_back_ios_new,
                    color: MyColors.myblack,
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
                  icon: const Icon(
                    Icons
                        .arrow_forward_ios,
                    color: MyColors.myblack,
                    size: 22.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
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
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontWeight:
                    FontWeight
                        .w500,
                    fontSize: 14,
                    color: MyColors.myWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
