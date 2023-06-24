import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import 'location.dart';

class rateDoctor extends StatefulWidget {
   rateDoctor({Key? key}) : super(key: key);

  @override
  State<rateDoctor> createState() => _rateDoctorState();
}

class _rateDoctorState extends State<rateDoctor> {

  String? lat, long, country, adminArea;
  double showRating =1.0;
  @override
  void initState(){
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Rate Dr. Fadi",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: HexColor("#000000"),
                  ),),
              ],
            ),
            const SizedBox(height: 16,),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: RatingBar.builder(
                  textDirection: TextDirection.rtl,
                  initialRating: showRating,
                  minRating: 1,
                  itemSize: 30,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding:
                  const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) =>
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (kDebugMode) {}
                    setState(() {
                      showRating = rating;
                      print(showRating);
                    });
                  },
                ),
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   // crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Icon(Icons.star,
              //       size: 40,
              //       color: HexColor("#A0A0A0"),),
              //     const SizedBox(width: 6.0,),
              //     Icon(Icons.star,
              //       size: 40,
              //       color: HexColor("#A0A0A0"),),
              //     const SizedBox(width: 6.0,),
              //     Icon(Icons.star,
              //       size: 40,
              //       color: HexColor("#A0A0A0"),),
              //     const SizedBox(width: 6.0,),
              //     Icon(Icons.star,
              //       size: 40,
              //       color: HexColor("#A0A0A0"),),
              //     const SizedBox(width: 6.0,),
              //     Icon(Icons.star,
              //       size: 40,
              //       color: HexColor("#A0A0A0"),),
              //   ],
              // ),
            ),
            const SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: ()
                  {
                    if(showRating <=4){
                      setState(() {
                        showRating++;

                      });
                    }
                  },
                  icon:Icon(Icons.arrow_back_ios_new,
                color:  HexColor("#000000"),
                  size: 22.0,
                ),),
                const SizedBox(width:49.0),
                Row(
                  children: [
                    Text("$showRating",

                    style: TextStyle(
                      fontSize:18,
                      fontWeight:  FontWeight.w400,
                      color: HexColor("#585858"),
                    ),),
                    Text("/5",style: TextStyle(
                      fontSize:18,
                      fontWeight:  FontWeight.w400,
                      color: HexColor("#585858"),
                    ),)
                  ],
                ),
                const SizedBox(width:49.0),
                IconButton(
                  onPressed:
                      (){
                    if(showRating >=1){
                      setState(() {
                        showRating--;

                      });
                    }

                      }, icon:Icon(Icons.arrow_forward_ios,
                color:  HexColor("#000000"),
                  size: 22.0,
                ),),

              ],
            ),
            const SizedBox(height: 38.0,),
            Container(width:double.infinity,
            height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: HexColor("#004DC0"),
              ),
              child: TextButton(
                onPressed: (){},
                child: Text("Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: HexColor("#FFFFFF"),
                ),),
              ),
            ),
            Text("Country : ${country ??' Loading ...'}"),
            Text("Admin Area : ${adminArea ??' Loading ...'}"),

          ],
        ),
      ),


    );
  }
  void getLocation()async{
    // final service = LocationService();
    // final locationData = await service.getLocation();

    // if(locationData != null){
    //   final placeMark = await service.getPlacemark(locationData : locationData);
    //   setState(() {
    //     lat = locationData.latitude!.toStringAsFixed(2);
    //     long = locationData.longitude!.toStringAsFixed(2);
    //
    //     country = placeMark?.country ?? 'could not get country';
    //     adminArea = placeMark?.administrativeArea ?? 'could not get admin area';
    //   });
    // }
  }
}
