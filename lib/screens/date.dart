// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class date_month extends StatefulWidget {
//
//    date_month({Key? key}) : super(key: key);
//
//   @override
//   State<date_month> createState() => _date_monthState();
// }
//
// class _date_monthState extends State<date_month> {
//   TextEditingController dateinput = TextEditingController();
//
//    @override
//    void initState() {
//      dateinput.text = "";
//      //set the initial value of text field
//      super.initState();
//    }
//
//    // dateinput.text = "";
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//
//         body: Container(
//             padding: const EdgeInsets.all(15),
//             height: 150,
//             child: Center(
//                 child: TextField(
//                   controller: dateinput,
//                   //editing controller of this TextField
//                   decoration: const InputDecoration(
//                       icon: Icon(Icons.calendar_today), //icon of text field
//                       labelText: "Enter Date" //label text of field
//                   ),
//                   readOnly: true,
//                   //set it true, so that user will not able to edit text
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         //DateTime.now() - not to allow to choose before today.
//                         lastDate: DateTime(2101));
//
//                     if (pickedDate != null) {
//                       if (kDebugMode) {
//                         print(pickedDate);
//                       } //pickedDate output format => 2021-03-10 00:00:00.000
//                       String formattedDate =
//                       DateFormat('yyyy-MM-dd').format(pickedDate);
//                       if (kDebugMode) {
//                         print(formattedDate);
//                       } //formatted date output using intl package =>  2021-03-16
//                       //you can implement different kind of Date Format here according to your requirement
//
//                       setState(() {
//                         dateinput.text =
//                             formattedDate; //set output date to TextField value.
//                       });
//                     } else {
//                       if (kDebugMode) {
//                         print("Date is not selected");
//                       }
//                     }
//                   },
//                 )
//             )
//         )
//     );
//
//   }
// }
