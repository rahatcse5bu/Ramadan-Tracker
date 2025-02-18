import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  final String title;
  final String text;

  const QuoteWidget({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(text),
      ),
    );
  }
}
