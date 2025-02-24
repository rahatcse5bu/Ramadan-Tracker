import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/app/common/widgets/custom_appbar_widget.dart';
import '../controller/borjoniyo_controller.dart';

class BorjoniyoView extends GetView<BorjoniyoController> {
  const BorjoniyoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(title: ''),
      body: Center(child: Align(
alignment: Alignment.center,
        child: ListView.builder(itemCount:controller.borjoniyoList.length , itemBuilder: (context, index) {
          String borjoniyoText = controller.borjoniyoList[index].text;
        
          return Card(
            elevation: 3.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ListTile(
              leading: Icon(Icons.close),
              title: Text(
                  borjoniyoText), // Assuming 'text' is the key for the text you want to display
            ),
          );
        }),
      )),
    );
  }
}
