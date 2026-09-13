import 'package:flutter/material.dart';
import '../future_phases/placeholder_screen.dart';

class KampHubScreen extends StatelessWidget {
  const KampHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Kamp Alanları (Harita)', 'icon': Icons.terrain, 'color': Colors.green[800]},
      {'title': 'Ücretsiz / Wild Camp', 'icon': Icons.nature_people, 'color': Colors.lightGreen[700]},
      {'title': 'Kamp Ekipman Pazarı', 'icon': Icons.storefront, 'color': Colors.brown},
      {'title': 'Ateş Başı Sohbet', 'icon': Icons.forum, 'color': Colors.orange[800]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamp Dünyası'),
        backgroundColor: Colors.green[900],
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
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceholderScreen(
                      title: item['title'],
                      icon: item['icon'],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: (item['color'] as Color).withOpacity(0.15),
                      child: Icon(item['icon'], size: 32, color: item['color']),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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