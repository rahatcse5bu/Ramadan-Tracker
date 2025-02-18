import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/common/widgets/cuatom_text_field_widget.dart' show CustomTextField;
import '../../../colors.dart';
import '../controller/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.PrimaryColor,
        leading: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 2, 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.offNamed('/koroniyo');
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: controller.usernameController,
                label: 'Username',
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: controller.fullNameController,
                label: 'Full Name',
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: controller.emailController,
                label: 'Email',
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
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: controller.register,
                        child: Text('Register'),
                      ),
                    )),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.toNamed('/login');
                },
                child: Text(
                  "Already have an account? Login here",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
