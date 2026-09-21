import 'package:flutter/material.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  final List<Map<String, dynamic>> allBadges = const [
    {
      'title': 'İlk Ateşi Yak',
      'desc': 'İlk kamp ateşi veya buluşma davetini başarıyla oluşturdun.',
      'icon': Icons.local_fire_department,
      'color': Colors.deepOrange,
      'isUnlocked': true,
      'xp': '+50 XP',
    },
    {
      'title': 'Motorcu Kaynaşması',
      'desc': 'Tanımadığın bir motorcunun yaktığı ateşe çay içmeye gittin.',
      'icon': Icons.handshake,
      'color': Colors.amber,
      'isUnlocked': true,
      'xp': '+75 XP',
    },
    {
      'title': 'Sosyal Gezgin',
      'desc': '5\'ten fazla toplu sürüşe veya kamp etkinliğine katıldın.',
      'icon': Icons.groups,
      'color': Colors.teal,
      'isUnlocked': true,
      'xp': '+150 XP',
    },
    {
      'title': 'Yaban Kurdu (Wild Camp)',
      'desc': 'Tesis dışı, tamamen doğada 3 gece çadır kampı tamamladın.',
      'icon': Icons.forest,
      'color': Colors.green,
      'isUnlocked': false,
      'xp': '+120 XP',
    },
    {
      'title': 'Yol Hızırı (SOS)',
      'desc': 'Yolda kalan veya arıza yapan bir motorcunun yardımına koştun.',
      'icon': Icons.healing,
      'color': Colors.redAccent,
      'isUnlocked': false,
      'xp': '+250 XP',
    },
    {
      'title': 'Demir Süvari',
      'desc': 'Uygulama üzerinden 1.000 km rota kaydı tamamladın.',
      'icon': Icons.military_tech,
      'color': Colors.indigo,
      'isUnlocked': false,
      'xp': '+300 XP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('İzci Rozetleri & Başarımlar'),
        backgroundColor: Colors.amber[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seviye ve İlerleme Kartı
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.blueGrey[900],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.amber,
                          child: Icon(Icons.shield, color: Colors.black87, size: 30),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seviye 3: Yol Dostu Gezgin',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '275 / 500 XP (Seviye 4 için 225 XP kaldı)',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const LinearProgressIndicator(
                        value: 275 / 500,
                        minHeight: 8,
                        backgroundColor: Colors.black38,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Tüm Rozetler',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            // Rozetler Grid Listesi
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allBadges.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78, // Kartların dikey ferahlığı artırıldı
              ),
              itemBuilder: (context, index) {
                final badge = allBadges[index];
                final bool unlocked = badge['isUnlocked'] as bool;

                return Card(
                  elevation: unlocked ? 3 : 1,
                  color: unlocked ? Colors.white : Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: unlocked ? (badge['color'] as Color).withOpacity(0.4) : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: unlocked
                              ? (badge['color'] as Color).withOpacity(0.15)
                              : Colors.grey.shade300,
                          child: Icon(
                            badge['icon'] as IconData,
                            size: 26,
                            color: unlocked ? badge['color'] as Color : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          badge['title'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: unlocked ? Colors.black87 : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          badge['desc'] as String,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: unlocked ? Colors.amber.shade100 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            unlocked ? badge['xp'] as String : 'Kilitli',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: unlocked ? Colors.amber.shade900 : Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}