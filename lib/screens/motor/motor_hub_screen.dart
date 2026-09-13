import 'package:flutter/material.dart';
import 'routes_screen.dart';
import 'meetup_screen.dart';
import 'clubs_screen.dart';
import '../profile/profile_screen.dart';

class MotorHubScreen extends StatelessWidget {
  const MotorHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Profilim', 'icon': Icons.person, 'color': Colors.blueGrey, 'isReady': true},
      {'title': 'Gezi & Rotalar', 'icon': Icons.alt_route, 'color': Colors.deepOrange, 'isReady': true},
      {'title': 'Buluşma & Tanışma', 'icon': Icons.local_fire_department, 'color': Colors.amber[800], 'isReady': true},
      {'title': 'Kulüpler', 'icon': Icons.groups, 'color': Colors.indigo, 'isReady': true},
      {'title': 'Servis & Ustalar', 'icon': Icons.build, 'color': Colors.grey, 'isReady': false},
      {'title': 'Motor Ekipmanları', 'icon': Icons.sports_motorsports, 'color': Colors.grey, 'isReady': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Motor Dünyası'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            final bool isReady = item['isReady'] as bool;

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                if (!isReady) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${item['title']} 2. Fazda kitle oluştuktan sonra açılacak.")),
                  );
                  return;
                }

                Widget target;
                if (item['title'] == 'Profilim') {
                  target = const ProfileScreen();
                } else if (item['title'] == 'Gezi & Rotalar') {
                  target = const RoutesScreen();
                } else if (item['title'] == 'Buluşma & Tanışma') {
                  target = const MeetupScreen();
                } else if (item['title'] == 'Kulüpler') {
                  target = const ClubsScreen();
                } else {
                  return;
                }

                Navigator.push(context, MaterialPageRoute(builder: (context) => target));
              },
              child: Card(
                elevation: isReady ? 4 : 1,
                color: isReady ? Colors.white : Colors.grey.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: (item['color'] as Color).withOpacity(0.15),
                            child: Icon(item['icon'], size: 30, color: item['color']),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isReady ? Colors.black87 : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isReady)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade800,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '2. Faz',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}