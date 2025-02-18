import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

class LeaderboardWidget extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("লিডারবোর্ড"),
      children: controller.users.map((user) {
        return ListTile(
          title: Text(user.userName),
          subtitle: Text(user.fullName),
          trailing: Text("${user.totalPoints} pts"),
        );
      }).toList(),
    );
  }
}
