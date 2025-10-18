import 'package:flutter/material.dart';

class TrafficApp extends StatefulWidget {
  const TrafficApp({super.key});

  @override
  State<TrafficApp> createState() => _TrafficAppState();
}

class _TrafficAppState extends State<TrafficApp> {
  int _currentLight = 0; // 0 = Red, 1 = Yellow, 2 = Green

  void _changeLight() {
    setState(() {
      _currentLight = (_currentLight + 1) % 3; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text('Traffic Light Animation'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ สัญญาณไฟแบบเรียงในแนวตั้ง
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _currentLight == 0 ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 800),
                  child: _buildLight(Colors.red),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _currentLight == 1 ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 800),
                  child: _buildLight(Colors.yellow),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _currentLight == 2 ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 800),
                  child: _buildLight(Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _changeLight,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
                foregroundColor: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: const Text(
                'เปลี่ยนไฟ',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLight(Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 6,
          ),
        ],
      ),
    );
  }
}
