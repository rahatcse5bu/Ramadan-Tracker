import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/storage/storage_controller.dart';

class LanguageController extends GetxController {
  final Rx<Locale?> _appLocale = Rx<Locale?>(null);

  Locale? get appLocale => _appLocale.value;

  @override
  void onInit() {
    _loadSavedLocale();
    super.onInit();
  }

  Future<void> _loadSavedLocale() async {
    final languageCode = await StorageHelper.getLanguageCode();
    final countryCode = await StorageHelper.getCountryCode();
    if (languageCode != null && countryCode != null) {
      _appLocale.value = Locale(languageCode, countryCode);
    }
  }

  Future<void> changeLanguage(String languageCode, String countryCode) async {
    await StorageHelper.setLanguage(languageCode, countryCode);
    _appLocale.value = Locale(languageCode, countryCode);
    Get.updateLocale(_appLocale.value!);
    update(); // Force UI update
  }
}