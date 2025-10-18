import 'package:flutter/material.dart';
import '../componets/Costom_widget_profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Custom Widget'),
        centerTitle: true,
      ),
      body: const Center(
        child: 
        ProfileCard(
          name: 'Danaitorn Saibiew',
          position: 'Programer',
          email: 'danaitorn.saibiew@gmail.com',
          phoneNumber: '0800856046',
          imageUrl:
              'https://static1.squarespace.com/static/62d09f54a49d6f1c78455cce/t/678f2fd99fdde4601470ee2c/1737437145217/T1+red.png?format=1500w',
        ),
      ),
    );
  }
}
