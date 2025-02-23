// lib/app/controllers/language_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/storage/storage_controller.dart';

class LanguageController extends GetxController {
  Future<void> changeLanguage(String languageCode, String countryCode) async {
    await StorageHelper.setLanguage(languageCode, countryCode);
    Get.updateLocale(Locale(languageCode, countryCode));
  }

  Future<Locale?> getInitialLocale() async {
    final String? languageCode = await StorageHelper.getLanguageCode();
    final String? countryCode = await StorageHelper.getCountryCode();
    
    if (languageCode != null && countryCode != null) {
      return Locale(languageCode, countryCode);
    }
    return null;
  }
}