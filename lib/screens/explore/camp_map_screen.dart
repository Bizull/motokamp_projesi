import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CampMapScreen extends StatefulWidget {
  const CampMapScreen({super.key});

  @override
  State<CampMapScreen> createState() => _CampMapScreenState();
}

class _CampMapScreenState extends State<CampMapScreen> {
  final MapController _mapController = MapController();

  // Test amacıyla haritada gösterilecek örnek kamp ve mola noktaları
  final List<Map<String, dynamic>> _campSpots = [
    {
      'name': 'Kozak Yaylası Çamlığı',
      'location': const LatLng(39.2333, 27.0167),
      'type': 'Doğal Kamp',
      'water': 'Çeşme Var',
      'fire': 'Ateş Yakılabilir',
      'desc': 'Çam ormanı içinde, motosikletle giriş yapılabilen sakin arazi.',
    },
    {
      'name': 'Spil Dağı Zirve Kampı',
      'location': const LatLng(38.5667, 27.4500),
      'type': 'Milli Park',
      'water': 'Tesis İçi',
      'fire': 'Sadece Ocak / Mangal',
      'desc': 'Manzara harika, virajlı tırmanış parkuru motosikletçiler için keyifli.',
    },
    {
      'name': 'Gölcük Krater Çevresi',
      'location': const LatLng(38.3167, 28.0167),
      'type': 'Göl Kenarı',
      'water': 'İşletmelerde Mevcut',
      'fire': 'Kontrollü Ateş',
      'desc': 'Göl manzarası ve serin akşamlar için ideal.',
    },
  ];

  void _showSpotDetails(Map<String, dynamic> spot) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.forest, color: Color(0xFFD9531E), size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      spot['name'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Chip(
                    label: Text(spot['type'], style: const TextStyle(fontSize: 11)),
                    backgroundColor: Colors.orange.shade50,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                spot['desc'],
                style: TextStyle(color: Colors.grey[800], fontSize: 13),
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFeatureBadge(Icons.water_drop, spot['water'], Colors.blue),
                  _buildFeatureBadge(Icons.local_fire_department, spot['fire'], Colors.deepOrange),
                  _buildFeatureBadge(Icons.two_wheeler, 'Araziye Uygun', Colors.green),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9531E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.navigation),
                  label: const Text('Bu Noktaya Rota Çiz'),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${spot['name']} için rota hesaplanıyor...')),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureBadge(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keşfet & Kamp Haritası'),
        backgroundColor: const Color(0xFFD9531E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              // Haritayı Ege Bölgesi merkezine geri odaklar
              _mapController.move(const LatLng(38.7, 27.5), 8.5);
            },
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: LatLng(38.7, 27.5), // Varsayılan merkez nokta
          initialZoom: 8.5,
          minZoom: 4.0,
          maxZoom: 18.0,
        ),
        children: [
          // 1. OpenStreetMap Kiremit (Tile) Katmanı
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.motokamp.app',
          ),

          // 2. Kamp Noktaları İşaretçileri (Markers)
          MarkerLayer(
            markers: _campSpots.map((spot) {
              return Marker(
                point: spot['location'],
                width: 44,
                height: 44,
                child: GestureDetector(
                  onTap: () => _showSpotDetails(spot),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9531E),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.two_wheeler,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}