import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../Data/data.dart';
import '../../../app/constants/app_color.dart';
import '../controller/ramadan_planner_controller.dart';

class AsmaulHusnaWidget extends GetWidget<RamadanPlannerController> {
  const AsmaulHusnaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(
            color: AppColors.primary,
            width: 1,
            style: BorderStyle.solid, //tablerow margin 10 from top and bottom
            borderRadius: BorderRadius.circular(5)),

        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        //tablerow margin 10 from top and bottom and 5 from left and

        children: [
          for (var name = controller.startName;
              name < controller.endName;
              name++) ...[
            TableRow(children: [
              Center(
                  child: Text(
                Asmaul_Husna[name],
                style: TextStyle(fontSize: 20),
              ))
            ]),
          ],
        ],
      ),
    );
  }
}
