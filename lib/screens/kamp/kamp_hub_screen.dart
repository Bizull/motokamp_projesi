import 'package:flutter/material.dart';
import 'camp_spots_screen.dart';
import 'camp_chat_screen.dart';

class KampHubScreen extends StatelessWidget {
  const KampHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Kamp Noktaları & Wild Camp', 'icon': Icons.terrain, 'color': Colors.green[800], 'isReady': true},
      {'title': 'Ateş Başı Sohbet & Davet', 'icon': Icons.whatshot, 'color': Colors.orange[800], 'isReady': true},
      {'title': 'Kamp Ekipman Pazarı', 'icon': Icons.storefront, 'color': Colors.grey, 'isReady': false},
      {'title': 'Kamp Yemekleri & İpuçları', 'icon': Icons.outdoor_grill, 'color': Colors.grey, 'isReady': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamp Dünyası'),
        backgroundColor: const Color(0xFF1B4332),
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
                    SnackBar(content: Text("${item['title']} 2. Fazda açılacak.")),
                  );
                  return;
                }

                Widget target;
                if (item['title'] == 'Kamp Noktaları & Wild Camp') {
                  target = const CampSpotsScreen();
                } else if (item['title'] == 'Ateş Başı Sohbet & Davet') {
                  target = const CampChatScreen();
                } else {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => target),
                );
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isReady ? Colors.black87 : Colors.grey[600],
                              ),
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
                            color: Colors.green.shade800,
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