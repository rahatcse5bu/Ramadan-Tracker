import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../app/constants/app_color.dart';
import '../controller/dashboard_controller.dart';

class QuoteWidget extends GetWidget<DashboardController> {
  final String title;
  final String text;
  final String? type;

  const QuoteWidget({required this.title, required this.text, this.type});

  @override
  Widget build(BuildContext context) {
    return       Container(
                    // width: 160,
                    child: Card(
                      elevation: 5.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                  color: AppColors.primary),
                              child: Center(
                                child: Text(
                                  "${title}",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // Divider(
                            //   color: AppColors.PrimaryColor,
                            //   thickness: 1.0,
                            // ),
                             controller.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ))
                                : ExpandableText(
                                    // todays_ayat.toString(),
                                    text.toString(),
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: AppColors.primary,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}
