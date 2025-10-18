import 'package:first_app/componets/CustomCounterWidget.dart';
import 'package:flutter/material.dart';

class CustomWidgetPage extends StatelessWidget {
  const CustomWidgetPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Custom Widget',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCounterWidget(title: 'TEAM A', backgroundColor: Colors.red),
            SizedBox(height: 10),
            CustomCounterWidget(title: 'TEAM B', backgroundColor: Colors.blue),
          ],
        ),
      ),
    );
  }
}