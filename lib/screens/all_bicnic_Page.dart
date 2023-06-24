import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';


import '../models/doctors_model.dart';
import '../shared/bloc/app_cubit/cubit.dart';
import '../shared/bloc/app_cubit/states.dart';
import '../shared/componants/components.dart';
import '../shared/styles/colors.dart';
import 'details_clinics.dart';

class allClinicsPage extends StatefulWidget {
  allClinicsPage({Key? key}) : super(key: key);

  @override
  State<allClinicsPage> createState() => _allClinicsPageState();
}

class _allClinicsPageState extends State<allClinicsPage> {
  List<DataDoctor>? allClinics;

  List<DataDoctor>? searchedForClinics;

  bool _isSearching = false;

  var searchController = TextEditingController();
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<DataDoctor>? doctorsModel = AppCubit.get(context).doctorList;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Clinics",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                  color: MyColors.myblack),
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
                        width: 0.5,
                        color: MyColors.myWhite,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.myWhite,
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
                      cursorColor: MyColors.myGrey,
                      onChanged: (searchedClinic) {
                        addSearchedFOrItemsToSearchedList(searchedClinic);
                      },
                      onFieldSubmitted: (value) {
                        // SearchCubit.get(context).search(searchController.text);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' clinics must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          'Search clinics',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: MyColors.myGrey,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: MyColors.myGrey,
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
                      const Icon(
                        Icons.filter_alt_sharp,
                        color: MyColors.myGreytext,
                        size: 15,
                      ),
                      const Text(
                        "sort by :",
                        style: TextStyle(
                          fontSize: 14,
                          color: MyColors.myGreytext,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: DropdownButton(
                            value: _value,
                            items:  const [
                              DropdownMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 17,
                                      color: MyColors.myblack,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text("Location"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 17, color: MyColors.myGrey,),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text("Rate"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        size: 17, color: MyColors.myGrey,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text("Price"),
                                    ],
                                  )
                              ),

                            ],
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                       ),
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
                          itemBuilder: (context, index) => detailsDocItem(
                              context,
                              searchController.text.isEmpty
                                  ? doctorsModel![index]
                                  : searchedForClinics![index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: searchController.text.isEmpty
                              ? doctorsModel!.length
                              : searchedForClinics!.length,
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
                  fit: BoxFit.fill,
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: MyColors.myWhite,
                          ),
                        ),
                        const Text(
                          "Orthopedics and joints specialist",
                          style: TextStyle(
                            fontSize: 8.0,
                            fontWeight: FontWeight.w300,
                            color: MyColors.myWhite,
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              size: 11,
                              color: MyColors.myYellow,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: MyColors.myYellow,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: MyColors.myYellow,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Icon(
                              Icons.star,
                              size: 11,
                              color: MyColors.myYellow,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Icon(Icons.star,
                                size: 11, color: MyColors.myWhite),
                          ],
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
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: MyColors.mydarkwhite),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            // softWrap: false,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: MyColors.mydarkwhite,
                            size: 11,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          if(model.workingHours!.start != null && model.workingHours!.end != null)
                            Text(
                              model.workingHours!.start! +" / " +model.workingHours!.end!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 8,
                                color: MyColors.mydarkwhite,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            size: 12.0,
                            color: MyColors.mydarkwhite,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          if (model.price != null)
                            Text(
                              "${model.price} LE/EGP",
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: MyColors.mydarkwhite,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    openWhatsApp(model.phone);
                  },
                  child: Container(
                    height: 37.0,
                    decoration: const BoxDecoration(
                      color: MyColors.myWhite,
                      // color: HexColor("#004DC0"),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40.0,
                        ),
                        const Text(
                          "contact",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myblue,
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
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );

  void addSearchedFOrItemsToSearchedList(String searchedClinic) {
    searchedForClinics = AppCubit.get(context)
        .doctorList!
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedClinic))
        .toList();
    setState(() {});
  }

  List<Widget> _buildFaiActios() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  void openWhatsApp(phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
