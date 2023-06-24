
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../shared/bloc/app_cubit/cubit.dart';
import '../../shared/bloc/app_cubit/states.dart';
import '../../shared/styles/colors.dart';

class xpone_layout extends StatelessWidget {
  const xpone_layout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            body: Stack(children: [
                cubit.bottomScreens[cubit.pageIndex],
                Padding(
                  padding: const EdgeInsets.only(right: 25,top: 49,bottom: 49,left: 25),
                  child: Align(
                    alignment: const Alignment(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:  HexColor("#0052CC").withOpacity(0.25),
                           spreadRadius: 3,
                            blurRadius: 12,
                            offset: const Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BottomNavigationBar(
                          selectedItemColor: MyColors.myblue,
                          unselectedItemColor: HexColor("#696969"),
                          showSelectedLabels: true,
                          showUnselectedLabels: false,
                          backgroundColor: MyColors.myWhite,
                          currentIndex: cubit.pageIndex,
                          onTap: (int index){
                           cubit.changeBottom(index);
                          },
                          items: const [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: "Home"
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.insert_page_break_outlined),
                              label: "Articles"
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: "Clinics"
                            ),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.settings,),
                              label: "Settings"
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
        );
      },

    );
  }
}