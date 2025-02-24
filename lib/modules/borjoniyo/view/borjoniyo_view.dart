import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/borjoniyo_controller.dart';

class BorjoniyoView extends GetView<BorjoniyoController> {
  const BorjoniyoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView.builder(itemBuilder: (context, index) {
              String borjoniyoText = controller.borjoniyoList[index].text;
            
               Card(
                elevation: 3.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListTile(
                  leading: Icon(Icons.close),
                  title: Text(borjoniyoText), // Assuming 'text' is the key for the text you want to display
                ),
              );}
            )));
  }
}
