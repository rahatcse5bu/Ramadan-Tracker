import 'package:flutter/material.dart';

class RamadanDaysList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("রমাদ্বন - ${index + 1}"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        );
      },
    );
  }
}
