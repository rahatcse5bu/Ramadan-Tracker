import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickJumpSectionController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {
    'maghrib': GlobalKey(),
    'qadr': GlobalKey(),
    'fajr': GlobalKey(),
    'zuhr': GlobalKey(),
    'common': GlobalKey(),
    'other': GlobalKey(),
    'asr': GlobalKey(),
    'night': GlobalKey(),
    'special': GlobalKey(),
  };

  void scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
