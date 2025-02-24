import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/app/common/widgets/custom_appbar_widget.dart';
import '../controller/koroniyo_controller.dart';

class KoroniyoView extends GetView<KoroniyoController> {
  const KoroniyoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(title: ''),
      body: Center(child: Align(
alignment: Alignment.center,
        child: ListView.builder(itemCount:controller.koroniyoList.length , itemBuilder: (context, index) {
          String koroniyoText = controller.koroniyoList[index].text;
        
          return Card(
            elevation: 3.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ListTile(
              leading: Icon(Icons.close),
              title: Text(
                  koroniyoText), // Assuming 'text' is the key for the text you want to display
            ),
          );
        }),
      )),
    );
  }
}
