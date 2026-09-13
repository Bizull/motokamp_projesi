import 'package:flutter/material.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  final List<Map<String, dynamic>> mockClubs = const [
    {
      'name': 'Anadolu Genç Motosikletliler (AGEM)',
      'city': 'İç Anadolu / Genel',
      'members': 340,
      'description': 'Kardeşlik, güvenli sürüş ve hafta sonu çadır kampları.',
      'badge': 'Resmi Dernek',
    },
    {
      'name': 'Erciyes Moto Kulübü',
      'city': 'Kayseri',
      'members': 125,
      'description': 'Dağ rotaları, yüksek irtifa ve enduro sürüş grubu.',
      'badge': 'Bölgesel Kulüp',
    },
    {
      'name': 'Kapadokya Gezgin Sürücüler',
      'city': 'Nevşehir / Aksaray',
      'members': 88,
      'description': 'Vadi turları ve sakin pazar sürüşleri topluluğu.',
      'badge': 'Topluluk',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motor Kulüpleri'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mockClubs.length,
        itemBuilder: (context, index) {
          final club = mockClubs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        child: const Icon(Icons.shield, color: Colors.indigo),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              club['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              '${club['city']} • ${club['members']} Üye',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(club['description'], style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.indigo,
                        side: const BorderSide(color: Colors.indigo),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${club['name']} kulübüne katılma isteği gönderildi!")),
                        );
                      },
                      child: const Text('Kulübe Katılma İsteği Gönder'),
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
}