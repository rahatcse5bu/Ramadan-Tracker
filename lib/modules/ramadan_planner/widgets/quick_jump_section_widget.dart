import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quick_jump_section_controller.dart';


class QuickJumpSections extends GetWidget<QuickJumpSectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Jump to Section Grid")),
      body: Column(
        children: [
          // Grid of Buttons
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.sectionKeys.keys.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 columns
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                String section = controller.sectionKeys.keys.elementAt(index);
                return GestureDetector(
                  onTap: () => controller.scrollToSection(section),
                  child: Card(
                    color: Colors.teal,
                    elevation: 4,
                    child: Center(
                      child: Text(
                        section,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      
        ],
      ),
    );
  }
}