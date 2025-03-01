import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';

import '../../apis/api_helper.dart';

class AppUpdateController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  RxInt latestVersionCode = 0.obs;
  RxString downloadUrl = ''.obs;

  Future<void> checkForUpdate() async {
    final response = await _apiHelper.getLatestVersionInfo();

    if (response.status.hasError) {
      Get.snackbar('Update Check Failed', 'Could not check for updates');
      return;
    }

    final data = response.body;

    latestVersionCode.value = data['latest_version_code'];
    downloadUrl.value = data['download_url'];

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersionCode = int.parse(packageInfo.buildNumber);

    if (latestVersionCode.value > currentVersionCode) {
      await downloadAndInstallApk();
    } else {
      debugPrint("App is up to date.");
    }
  }

  Future<void> downloadAndInstallApk() async {
    final savedDir = '/storage/emulated/0/Download';
    final fileName = 'app-latest.apk';

    final taskId = await FlutterDownloader.enqueue(
      url: downloadUrl.value,
      savedDir: savedDir,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: false,
    );

    FlutterDownloader.registerCallback((id, status, progress) async {
      if (id == taskId && status == DownloadTaskStatus.complete) {
        final filePath = '$savedDir/$fileName';
        await triggerApkInstallation(filePath);
      }
    });
  }

  Future<void> triggerApkInstallation(String filePath) async {
    if (Platform.isAndroid) {
      await OpenFilex.open(filePath);
    } else {
      Get.snackbar('Unsupported Platform', 'This auto-update only works on Android.');
    }
  }
}
