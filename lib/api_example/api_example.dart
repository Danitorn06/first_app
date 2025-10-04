import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  State<ApiExample> createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {
  void fetchUser() async {
    try {
      var response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        User user = User.fromJson(data);
        print('Name: ${user.name}');
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Example")),
      body: Placeholder(),
    );
  }
}

// Model Class
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  // Constructor
  User(this.id, this.name, this.username, this.email);
  // แปลง JSON เป็น Object
  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      username = json['username'],
      email = json['email'];
  // แปลง Object เป็น JSON Map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'username': username, 'email': email};
  }
}
