import 'package:flutter/material.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  final List<Map<String, dynamic>> mockRoutes = const [
    {
      'title': 'Ihlara Vadisi - Hasan Dağı Geçişi',
      'distance': '85 km',
      'duration': '1s 45dk',
      'difficulty': 'Orta',
      'surface': 'Virajlı Asfalt / Stabilize',
      'campSpot': 'Hasan Dağı Etekleri (Ücretsiz Su Var)',
      'rating': 4.8,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Erciyes Dağ Çevresi Turu',
      'distance': '140 km',
      'duration': '2s 30dk',
      'difficulty': 'İleri (Yüksek İrtifa)',
      'surface': 'Yüksek Kalite Asfalt',
      'campSpot': 'Tekir Yaylası Çadır Alanı',
      'rating': 4.9,
      'color': Colors.indigo,
    },
    {
      'title': 'Tuz Gölü Gün Batımı Rotası',
      'distance': '110 km',
      'duration': '1s 30dk',
      'difficulty': 'Kolay / Keyif',
      'surface': 'Düz Hat / Uzun Yol',
      'campSpot': 'Göl Kenarı Kumul Kampı',
      'rating': 4.6,
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gezi & Rotalar'),
        backgroundColor: Colors.deepOrange[800],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mockRoutes.length,
        itemBuilder: (context, index) {
          final item = mockRoutes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'],
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              item['rating'].toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _buildBadge(Icons.straighten, item['distance']),
                      _buildBadge(Icons.timer_outlined, item['duration']),
                      _buildBadge(Icons.speed, item['difficulty']),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.terrain, size: 18, color: Colors.blueGrey),
                      const SizedBox(width: 6),
                      Text('Zemin: ${item['surface']}', style: const TextStyle(fontSize: 13, color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.cabin, size: 18, color: Colors.green),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Kamp: ${item['campSpot']}',
                          style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item['title']} GPX rotası 2. Fazda haritaya çizilecek!')),
                        );
                      },
                      icon: const Icon(Icons.navigation, size: 18),
                      label: const Text('Rotayı İncele (Haritada Gör)'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.blueGrey),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}