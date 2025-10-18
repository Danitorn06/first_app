import 'package:flutter/material.dart';
//import 'form_example/form_example1.dart';
//import 'api_example/api_example.dart';
//import 'api_example/api_exampleList.dart';
//import 'api_example/AssigmentWeek5.dart';
//import 'page/CustomWidgetPage.dart';
//import 'page/ProfilePage.dart';
//import 'page/test_dark_light.dart';
//import 'page/setting_page.dart';
//import 'page/aminimated_simple.dart';
import 'page/TrafficApp.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Week 4 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      //home: const FormExample(),
      //home: const CustomWidgetPage(),
      //home: const ApiExampleList(),
      //home: const RegistrationForm(),
      //home: const AnimatedTest(),
      //home: const SettingPage(),
      //home: const AnimatedBox(),
      home: const TrafficApp(),
    );
}
}