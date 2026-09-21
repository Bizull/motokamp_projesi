import 'package:flutter/material.dart';

class CampSpotsScreen extends StatefulWidget {
  const CampSpotsScreen({super.key});

  @override
  State<CampSpotsScreen> createState() => _CampSpotsScreenState();
}

class _CampSpotsScreenState extends State<CampSpotsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> wildSpots = const [
    {
      'name': 'Hasan Dağı Yılkant Yaylası',
      'location': 'Aksaray / Hasan Dağı Etekleri',
      'distance': '45 km yakında',
      'type': 'Ücretsiz / Wild Camp',
      'waterSource': 'Doğal Kaynak Suyu Var (100m)',
      'fireAllowed': 'Serbest (Köz Çukuru Mevcut)',
      'roadCondition': 'Toprak / Stabilize (Enduro / Adventure Uygun)',
      'phoneSignal': 'Kısmen Çekiyor (Turkcell/Vodafone)',
      'rating': 4.9,
      'isMotorcycleAccessible': true,
    },
    {
      'name': 'Erciyes Tekir Yaylası Gölet Kenarı',
      'location': 'Kayseri / Erciyes',
      'distance': '80 km yakında',
      'type': 'Ücretsiz / Wild Camp',
      'waterSource': 'Çeşme Mevcut',
      'fireAllowed': 'Yalnızca Ocak/Mangal',
      'roadCondition': 'Asfalt Sonrası 1 km Düz Toprak Yol',
      'phoneSignal': 'Güçlü Çekiyor',
      'rating': 4.7,
      'isMotorcycleAccessible': true,
    },
    {
      'name': 'Ihlara Kanyonu Üst Platoları',
      'location': 'Aksaray / Güzelyurt',
      'distance': '62 km yakında',
      'type': 'Ücretsiz / Manzara Kampı',
      'waterSource': 'Su Yok (Yanınza Alın)',
      'fireAllowed': 'Ateş Yakılamaz (Rüzgarlı)',
      'roadCondition': 'Sert Taş Zemin',
      'phoneSignal': 'Zayıf',
      'rating': 4.5,
      'isMotorcycleAccessible': false,
    },
  ];

  final List<Map<String, dynamic>> facilitySpots = const [
    {
      'name': 'Kapadokya Panorama Kamping',
      'location': 'Göreme / Nevşehir',
      'distance': '110 km',
      'type': 'İşletme Kampı',
      'price': '350 TL / Çadır Başı',
      'amenities': ['WC & Duş', 'Elektrik', 'Sıcak Su', 'Wi-Fi'],
      'roadCondition': 'Tamamen Asfalt',
      'rating': 4.6,
    },
    {
      'name': 'Gümüşler Doğa Kamping',
      'location': 'Niğde / Merkez',
      'distance': '75 km',
      'type': 'İşletme Kampı',
      'price': '250 TL / Çadır Başı',
      'amenities': ['WC', 'Kafeterya', 'Motosiklet Parkı'],
      'roadCondition': 'Asfalt',
      'rating': 4.4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Kamp Noktaları & Alanlar'),
        backgroundColor: const Color(0xFF1B4332), // Doğa yeşili
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.lightGreenAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.nature_people), text: 'Wild Camp (Doğa)'),
            Tab(icon: Icon(Icons.holiday_village), text: 'Tesis & İşletmeler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Sekme: Wild Camp (Ücretsiz / Doğa İçinde)
          ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: wildSpots.length,
            itemBuilder: (context, index) {
              final spot = wildSpots[index];
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              spot['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  spot['rating'].toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.deepOrange),
                          const SizedBox(width: 4),
                          Text(spot['location'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          const Spacer(),
                          Text(spot['distance'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(height: 20),
                      _buildDetailRow(Icons.water_drop, 'Su Kaynağı:', spot['waterSource'], Colors.blue),
                      const SizedBox(height: 6),
                      _buildDetailRow(Icons.local_fire_department, 'Ateş Durumu:', spot['fireAllowed'], Colors.orange),
                      const SizedBox(height: 6),
                      _buildDetailRow(Icons.alt_route, 'Yol Tipi:', spot['roadCondition'], Colors.brown),
                      const SizedBox(height: 6),
                      _buildDetailRow(Icons.signal_cellular_alt, 'Telefon/Hat:', spot['phoneSignal'], Colors.teal),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B4332),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${spot['name']} GPS koordinatı haritada açılacak!")),
                            );
                          },
                          icon: const Icon(Icons.directions, size: 18),
                          label: const Text('Konuma Git / Koordinatları Al'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 2. Sekme: İşletme & Tesis Kamp Alanları
          ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: facilitySpots.length,
            itemBuilder: (context, index) {
              final spot = facilitySpots[index];
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              spot['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Text(
                            spot['price'],
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${spot['location']} • ${spot['distance']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: (spot['amenities'] as List<String>)
                            .map((amenity) => Chip(
                                  label: Text(amenity, style: const TextStyle(fontSize: 11)),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.green.shade50,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1B4332),
                            side: const BorderSide(color: Color(0xFF1B4332)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${spot['name']} tesis iletişimine yönlendiriliyor.")),
                            );
                          },
                          icon: const Icon(Icons.call, size: 16),
                          label: const Text('İşletmeyi Ara / Rezervasyon'),
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
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Text('$label ', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}