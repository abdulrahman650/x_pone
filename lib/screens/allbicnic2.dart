

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../models/doctors_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/componants/components.dart';
import '../shared/styles/colors.dart';
import 'details_clinics.dart';

class allClinicsPage2 extends StatefulWidget {
  allClinicsPage2({Key? key}) : super(key: key);

  @override
  State<allClinicsPage2> createState() => _allClinicsPage2State();
}

class _allClinicsPage2State extends State<allClinicsPage2> {
   List<DataDoctor>? doctorsModel;

   List<DataDoctor>? searchedForClinics;

  bool _isSearching = false;

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<DataDoctor>? doctorsModel = AppCubit.get(context).doctorList;

        return Scaffold(
          appBar:AppBar(
            backgroundColor: MyColors.myYellow,
            title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
            actions: _buildAppBarActions(),
            leading: _isSearching ? BackButton(color: MyColors.myGrey,)
                :Container(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [

                  // Container(
                  //   width: double.infinity,
                  //   height: 44.0,
                  //   decoration: BoxDecoration(
                  //     border:
                  //     Border.all(width: 0.5, color: HexColor("#FFFFFF")),
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: HexColor("#0052CC").withOpacity(0.1),
                  //         spreadRadius: 3,
                  //         blurRadius: 9,
                  //         offset:
                  //         const Offset(0, 9), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child: TextFormField(
                  //     controller: searchController,
                  //     keyboardType: TextInputType.text,
                  //     cursorColor: HexColor("#94A3B8"),
                  //     onChanged: (searchedClinic) {
                  //       addSearchedFOrItemsToSearchedList(searchedClinic);
                  //     },
                  //     onFieldSubmitted: (value) {
                  //       // SearchCubit.get(context).search(searchController.text);
                  //     },
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return ' clinics must not be empty';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       label: Text(
                  //         'Search clinics',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 14,
                  //           color: HexColor("#94A3B8"),
                  //         ),
                  //       ),
                  //       suffixIcon: Icon(
                  //         Icons.search,
                  //         color: HexColor("#94A3B8"),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                        child: const Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  state is xBoneLoadingDoctorsStates
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        detailsDocItem(context, searchController.text.isEmpty? doctorsModel![index]  : searchedForClinics![index]),

                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15.0,
                    ),
                    itemCount: searchController.text.isEmpty? doctorsModel!.length : searchedForClinics!.length,
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

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Search clinics....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedClinic) {
        addSearchedFOrItemsToSearchedList(searchedClinic);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedClinic) {
    searchedForClinics = AppCubit.get(context).doctorList!
        .where((doctorsModel) =>
        doctorsModel.name!.toLowerCase().startsWith(searchedClinic))
        .toList();
    setState((){

    });
  }
  List<Widget> _buildAppBarActions(){
    if(_isSearching){
      return[
        IconButton(onPressed:(){
          _clearSearch();
          Navigator.pop(context);
        } ,icon:Icon(Icons.clear,color: MyColors.myGrey,) ,),
      ];
    }else{
      return [
        IconButton(onPressed: _startSearch, icon: Icon(Icons.search,color: MyColors.myGrey,))

      ];
    }
  }
  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove:_stopSearching ));

    setState((){
      _isSearching =true;
    });
  }
  void _stopSearching(){
    _clearSearch();
    setState((){
      _isSearching =false;
    });
  }
  void _clearSearch(){
    setState((){
      searchController.clear();
    });

  }
  Widget _buildAppBarTitle(){
    return Text("Clinics",
      style: TextStyle(color: MyColors.myGrey),);
  }


   // double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
   //   const int earthRadius = 6371; // Radius of the Earth in kilometers
   //   double lat1 = startLatitude * (pi / 180);
   //   double lon1 = startLongitude * (pi / 180);
   //   double lat2 = endLatitude * (pi / 180);
   //   double lon2 = endLongitude * (pi / 180);
   //
   //   double dLat = lat2 - lat1;
   //   double dLon = lon2 - lon1;
   //
   //   double a = sin(dLat / 2) * sin(dLat / 2) +
   //       cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
   //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
   //   double distance = earthRadius * c;
   //
   //   return distance;
   // }
   //
   // List<DataDoctor> findNearestDoctors(double userLatitude, double userLongitude, List<DataDoctor> doctors, int limit) {
   //   doctors.sort((a, b) {
   //     double distanceToA = calculateDistance(userLatitude, userLongitude, double.parse(a.lat!), double.parse(a.long!));
   //     double distanceToB = calculateDistance(userLatitude, userLongitude,  double.parse(b.lat!), double.parse(b.long!));
   //     return distanceToA.compareTo(distanceToB);
   //   });
   //
   //   return doctors.sublist(0, limit);
   // }
   //
   // // Find the nearest doctors
   // List<DataDoctor> nearestDoctors = findNearestDoctors(userLatitude, userLongitude, doctors, 3);
   //
   // // Print the nearest doctors
   // for (DataDoctor doctor in nearestDoctors) {
   // print('Name: ${doctor.name}, Latitude: ${doctor.latitude}, Longitude: ${doctor.longitude}');
   // }
}
