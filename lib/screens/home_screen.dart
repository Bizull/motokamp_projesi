import 'package:flutter/material.dart';
import 'motor/motor_hub_screen.dart';
import 'kamp/kamp_hub_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MotoKamp', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Rotanı Seç, Maceraya Başla',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              const SizedBox(height: 25),
              
              // MOTOR KARTI
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MotorHubScreen()),
                    );
                  },
                  child: Card(
                    elevation: 6,
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.two_wheeler, size: 85, color: Colors.orangeAccent),
                          SizedBox(height: 12),
                          Text(
                            'MOTOR',
                            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
                          ),
                          Text(
                            'Rotalar, Servisler, Kulüpler',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              // KAMP KARTI
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const KampHubScreen()),
                    );
                  },
                  child: Card(
                    elevation: 6,
                    color: const Color(0xFF1B4332), // Doğa yeşili
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cabin, size: 85, color: Colors.lightGreenAccent),
                          SizedBox(height: 12),
                          Text(
                            'KAMP',
                            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
                          ),
                          Text(
                            'Alanlar, Wild Camp, Ateş Başı',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}