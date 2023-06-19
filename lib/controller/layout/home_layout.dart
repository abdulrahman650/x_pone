// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:x_pone/screens/home/home.dart';
// import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
// import 'package:x_pone/shared/bloc/app_cubit/states.dart';
// import 'package:x_pone/shared/componants/components.dart';
//
//
//
//
// class XponeLayout extends StatelessWidget {
//   const XponeLayout({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = AppCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             elevation: 5.0,
//             title: Text(
//               'X Pone'.toUpperCase(),
//               style: const TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   navigateTo(context, home());
//                 },
//                 icon: const Icon(
//                   Icons.search,
//                 ),
//               )
//             ],
//           ),
//           body:
//           // cubit.bottomScreens[cubit.currentIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             onTap: (index) {
//               // cubit.changeBottom(index);
//             },
//             currentIndex: cubit.currentIndex,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home_filled,
//                 ),
//                 label: 'One',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.category_outlined,
//                 ),
//                 label: 'Two',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.favorite,
//                 ),
//                 label: 'Three',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.settings,
//                 ),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:x_pone/screens/all_bicnic_Page.dart';
import 'package:x_pone/screens/homePage.dart';
import 'package:x_pone/screens/allExercises_Page.dart';
import 'package:x_pone/screens/settingPage.dart';
import 'package:x_pone/shared/bloc/app_cubit/cubit.dart';
import 'package:x_pone/shared/bloc/app_cubit/states.dart';

class XponeLayout extends StatelessWidget {

  const XponeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            body:
            Stack(
              children: [
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
                            offset: Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BottomNavigationBar(
                          selectedItemColor: HexColor("#0F57C3"),
                          unselectedItemColor: HexColor("#696969"),

                          showSelectedLabels: true,
                          showUnselectedLabels: false,
                          backgroundColor: Colors.white,
                          currentIndex: cubit.pageIndex,
                          onTap: (int index){
                           cubit.changeBottom(index);
                            // setState((){
                            //   pageIndex = index;
                            // });
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