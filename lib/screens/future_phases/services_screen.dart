import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  final List<Map<String, dynamic>> mockServices = const [
    {
      'name': 'Gezgin Motor Servis & Yedek Parça',
      'owner': 'Mehmet Usta',
      'location': 'Merkez Sanayi Sitesi',
      'distance': '3.2 km yakında',
      'specialty': 'Touring, Enduro, Mekanik & Zincir Bakımı',
      'isEmergency': true,
      'isVerified': true,
      'phone': '0555 123 45 67',
    },
    {
      'name': 'Dostlar Motosiklet Tamir Evi',
      'owner': 'Ali & Hasan Usta',
      'location': 'Eski Sanayi 4. Blok',
      'distance': '7.8 km yakında',
      'specialty': 'Scooter, Elektrik & Akü Değişimi, Lastik Onarımı',
      'isEmergency': false,
      'isVerified': true,
      'phone': '0555 987 65 43',
    },
    {
      'name': 'Anadolu Kamp & Motor Garajı',
      'owner': 'Murat Usta',
      'location': 'Çevre Yolu Çıkışı',
      'distance': '12.0 km yakında',
      'specialty': 'Çanta Demiri Kaynağı, Far Ayarı, Yol Yardımı',
      'isEmergency': true,
      'isVerified': false,
      'phone': '0555 444 33 22',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servis & Ustalar'),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mockServices.length,
        itemBuilder: (context, index) {
          final service = mockServices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blueGrey.shade100,
                        child: const Icon(Icons.build, color: Colors.blueGrey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    service['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                if (service['isVerified']) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.verified, size: 18, color: Colors.blue),
                                ],
                              ],
                            ),
                            Text(
                              '${service['owner']} • ${service['location']}',
                              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: Colors.blueGrey),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            service['specialty'],
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                          Text(
                            service['distance'],
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (service['isEmergency'])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '7/24 Acil Yol Yardımı',
                            style: TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone, size: 16),
                          label: const Text('Ustayla Ara'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[800],
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.directions, size: 16),
                          label: const Text('Yol Tarifi'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}