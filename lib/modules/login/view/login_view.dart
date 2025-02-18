import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/app/routes/app_pages.dart';
import 'package:ramadan_tracker/modules/login/controller/login_controller.dart';

import '../../../app/common/widgets/cuatom_text_field_widget.dart';
import '../../../colors.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryColor,
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: controller.identifierController,
              label: 'Username/Email',
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: controller.passwordController,
              label: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: controller.login,
                    child: Text('Login', style: TextStyle(fontSize: 20)),
                  )),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.register);
              },
              child: Text(
                "New to Ramadan Tracker? Register here",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
