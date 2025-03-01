import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis/api_helper.dart';
import '../../apis/api_helper_implementation.dart';

class AppUpdateController extends GetxController {
  // final ApiHelper _apiHelper = Get.find<ApiHelper>();
  
  late final ApiHelper _apiHelper;
        // Add this!
          RxString latestVersion = ''.obs;
  RxString downloadUrl = ''.obs;

   Future<void> checkForUpdate() async {
    try {
      final updateInfo = await _apiHelper.fetchLatestVersion();
      latestVersion.value = updateInfo['version'];
      downloadUrl.value = updateInfo['download_link'];

      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      if (_isUpdateAvailable(currentVersion, latestVersion.value)) {
        showUpdateDialog();
      } else {
        print('✅ App is up-to-date');
      }
    } catch (e) {
      print('❌ Error checking for update: $e');
    }
  }

  bool _isUpdateAvailable(String currentVersion, String latestVersion) {
    return _compareVersions(currentVersion, latestVersion) < 0;
  }

  int _compareVersions(String v1, String v2) {
    List<int> parts1 = v1.split('.').map(int.parse).toList();
    List<int> parts2 = v2.split('.').map(int.parse).toList();
    for (int i = 0; i < parts1.length || i < parts2.length; i++) {
      final part1 = i < parts1.length ? parts1[i] : 0;
      final part2 = i < parts2.length ? parts2[i] : 0;
      if (part1 != part2) {
        return part1.compareTo(part2);
      }
    }
    return 0;
  }

  void showUpdateDialog() {
    Get.defaultDialog(
      title: 'Update Available',
      content: const Text('A new version of the app is available. Please update to continue.'),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();  // Close dialog
          downloadAndInstallApk();
        },
        child: const Text('Update Now'),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Later'),
      ),
    );
  }

  Future<void> downloadAndInstallApk() async {
    final apkUrl = downloadUrl.value;
    print('📥 Download URL: $apkUrl');

    // Easiest option - just open the download link in browser
    if (!await GetUtils.isURL(apkUrl)) {
      Get.snackbar('Invalid URL', 'The provided download link is invalid.');
      return;
    }

    await launchDownloadUrl(apkUrl);
  }

  Future<void> launchDownloadUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      Get.snackbar('Failed', 'Could not open download link.');
    }
  }
  @override
  void onInit() {
    super.onInit();
    _apiHelper = Get.put(ApiHelperImpl());   // Or Get.lazyPut if needed
  }
  
}
