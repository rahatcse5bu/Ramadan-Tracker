import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../app/constants/app_color.dart';
import '../../../app/translation/translation_keys.dart';
import '../controller/dashboard_controller.dart';

class QuoteWidget extends GetWidget<DashboardController> {
  final String title;
  final String text;
  final String? type;

  const QuoteWidget({required this.title, required this.text, this.type});

  // Getter to return the proper text based on type
  String get displayText {
    switch (type) {
      case 'ajker_ayat':
        return controller.ajkerAyat.value;
      case 'ajker_hadith':
        return controller.ajkerHadith.value;
      case 'salaf_quote':
        return controller.ajkerSalafQuote.value;
      default:
        return text;
    }
  }
  String get displayTitle {
    switch (type) {
      case 'ajker_ayat':
        return TranslationKeys.selectedVerses.tr;
      case 'ajker_hadith':
        return TranslationKeys.selectedHadith.tr;
      case 'salaf_quote':
        return TranslationKeys.salafQuotes.tr;
      default:
        return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          // width: 160,
          child: Card(
            elevation: 5.2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)),
                        color: AppColors.primary),
                    child: Center(
                      child: Text(
                        "$displayTitle",
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
                          child: CupertinoActivityIndicator(color: AppColors.primary,))
                      : ExpandableText(
                          displayText,
                          // controller.ajkerAyat.value,
                          expandText: 'show more',
                          collapseText: 'show less',
                          maxLines: 4,
                          linkColor: AppColors.primary,
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
