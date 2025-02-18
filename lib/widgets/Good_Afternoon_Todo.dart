//import main.dart
import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ramadan_tracker/colors.dart';
import 'package:ramadan_tracker/Data/data.dart';

import '../Data/localStorageFunc.dart';

class Good_Afternoon_Todo extends StatefulWidget {
  Good_Afternoon_Todo({super.key, required this.ramadan_day});
  int ramadan_day;
  @override
  State<Good_Afternoon_Todo> createState() => _Good_Afternoon_TodoState();
}

class _Good_Afternoon_TodoState extends State<Good_Afternoon_Todo> {
  bool? val = false;
  final LocalStorage storage = new LocalStorage('ramadan_tracker');

  TextEditingController quran_ayat_hifz_controller =
      new TextEditingController();
  TextEditingController natun_maswala_sikha_controller =
      new TextEditingController();
  TextEditingController islamic_natun_kisu_sikha_controller =
      new TextEditingController();
  TextEditingController quran_tilwat_kora_controller =
      new TextEditingController();
  TextEditingController quran_tafsir_pora_controller =
      new TextEditingController();
  TextEditingController dua_mukhusto_kora_controller =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Todo list with SwitchListTile widget and a button to add new todo
        Column(children: [
          // Card(
          //     elevation: 5,
          //     child: Padding(
          //         padding: EdgeInsets.all(10.0),
          //         child: Column(children: [
          //           Container(
          //             padding:
          //                 EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //             margin: EdgeInsets.only(bottom: 5),
          //             width: MediaQuery.of(context).size.width,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(6),
          //                     topRight: Radius.circular(6)),
          //                 color: AppColors.PrimaryColor),
          //             child: Center(
          //               child: Text(
          //                 "বিকেল ট্রাকিং",
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 20,
          //                     color: Colors.white),
          //               ),
          //             ),
          //           ),
          //           // CheckboxListTile

          //           for (var i = 0; i < Good_Afternoon_Items.length; i++) ...[
          //             SwitchListTile(
          //               secondary: Good_Afternoon_Items[i]['isChecked'] == false
          //                   ? Icon(
          //                       Icons.close,
          //                       color: Colors.red,
          //                     )
          //                   : Icon(
          //                       Icons.check,
          //                       color: AppColors.PrimaryColor,
          //                     ),
          //               activeColor:
          //                   Good_Afternoon_Items[i]['isChecked'] == false
          //                       ? Colors.red
          //                       : AppColors.PrimaryColor,
          //               controlAffinity: ListTileControlAffinity.leading,
          //               title: Text(Good_Afternoon_Items[i]['title']),
          //               isThreeLine: true,
          //               subtitle: ExpandableText(
          //                 Good_Afternoon_Items[i]['subTitle'],
          //                 expandText: 'show more',
          //                 collapseText: 'show less',
          //                 maxLines: 2,
          //                 linkColor: Colors.blue,
          //                 style: TextStyle(
          //                     fontStyle: FontStyle.italic, fontSize: 12),
          //               ),
          //               value: Good_Afternoon_Items[i]['isChecked'],
          //               onChanged: (bool? newValue) {
          //                 setState(() {
          //                   Good_Afternoon_Items[i]['isChecked'] = newValue;
          //                   setValueToLocalStorage(
          //                       'Good_Afternoon_Items' +
          //                           widget.ramadan_day.toString(),
          //                       json.encode(Good_Afternoon_Items));
          //                   if (Good_Afternoon_Items.where(
          //                           (e) => e['isChecked'] == true).length ==
          //                       Good_Afternoon_Items.length) {
          //                     showDialog(
          //                         context: context,
          //                         builder: (BuildContext context) {
          //                           return AlertDialog(
          //                             title: Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.spaceBetween,
          //                               children: [
          //                                 Icon(Icons.check_circle,
          //                                     color: AppColors.PrimaryColor),
          //                                 SizedBox(width: 2),
          //                                 Text('জাযাকাল্লহু খইরন!'),
          //                               ],
          //                             ),
          //                             content: Text(
          //                                 "জাযাকাল্লহু খইরন। আপনি সফলভাবে আজকের বিকেলের কাজগুলো সম্পন্ন করেছেন! "),
          //                             actions: [
          //                               TextButton(
          //                                 onPressed: () {
          //                                   Navigator.of(context).pop();
          //                                 },
          //                                 child: Center(child: Text('ঠিক আছে')),
          //                               ),
          //                             ],
          //                           );
          //                         });
          //                     print("All Done");
          //                   }
          //                   storage.setItem(
          //                       'Good_Afternoon_Items_Count' +
          //                           widget.ramadan_day.toString(),
          //                       Good_Afternoon_Items.where(
          //                           (e) => e['isChecked'] == true).length);
          //                   print(Good_Afternoon_Items.where(
          //                       (e) => e['isChecked'] == true).length);
          //                 });
          //               },
          //             ),
          //           ]
          //         ]))),

          // card widget with input field having "add" button with dynamic texteditingcontroller within loop
          SizedBox(
            height: 10,
          ),
          Card(
              elevation: 5,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6)),
                          color: AppColors.PrimaryColor),
                      child: Center(
                        child: Text(
                          "আজকের অন্যান্য কার্যক্রম:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "বিস্তারিত লিখে  আপডেট বাটনে ক্লিক করুন:",
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                    ),
                    // CheckboxListTile
                    SizedBox(
                      height: 10,
                    ),
                    for (var i = 0;
                        i < Good_Afternoon_Items_inputs.length;
                        i++) ...[
                      // Textinput field with dynamic texteditting controller
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: Good_Afternoon_Items_inputs[i]
                                ['controller'],
                            decoration: InputDecoration(
                              labelText: Good_Afternoon_Items_inputs[i]
                                  ['title'],
                              hintText: Good_Afternoon_Items_inputs[i]['Value'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              storage.setItem(
                                  'Good_Afternoon_Items_inputs_' +
                                      widget.ramadan_day.toString() +
                                      "_" +
                                      i.toString(),
                                  Good_Afternoon_Items_inputs[i]['controller']
                                      .text);
                              //show toast
                              Fluttertoast.showToast(
                                  msg: "আপনার তথ্য সংরক্ষণ করা হয়েছে",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              // print(Good_Afternoon_Items_inputs.toString());
                            },
                            child: Good_Afternoon_Items_inputs[i]['Value'] ==
                                        null ||
                                    Good_Afternoon_Items_inputs[i]['Value'] ==
                                        '' ||
                                    Good_Afternoon_Items_inputs[i]['Value'] ==
                                        " "
                                ? Text("Add করুন",
                                    style: TextStyle(color: Colors.white))
                                : Text("আপডেট করুন",
                                    style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(6), // <-- Radius
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ]))),
        ])
      ],
    );
  }
}
