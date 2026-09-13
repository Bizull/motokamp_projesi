import 'package:flutter/material.dart';

class MeetupScreen extends StatefulWidget {
  const MeetupScreen({super.key});

  @override
  State<MeetupScreen> createState() => _MeetupScreenState();
}

class _MeetupScreenState extends State<MeetupScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> activeSignals = [
    {
      'host': 'Barış Demir',
      'hostAvatar': 'B',
      'bike': 'KTM 890 Adventure',
      'title': 'Hasan Dağı Oteller Bölgesi - Közde Çay',
      'description': 'Çadırı kurduk, ateşi yaktık. Çay demleniyor, rotada olan tüm dostları sohbete bekleriz!',
      'distance': '14 km yakında',
      'timeRemaining': '3 saat açık',
      'attendees': 4,
      'isLive': true,
      'tags': ['Ateş Yanıyor', 'Çadır Var', 'Müzik Yok'],
    },
    {
      'host': 'Gökhan & Selin',
      'hostAvatar': 'G',
      'bike': 'BMW F850 GS',
      'title': 'Ihlara Kanyonu Mola Yeri',
      'description': 'Kısa bir kahve molası verdik, 45 dakika buradayız. Selamlaşmak isteyen uğrayabilir.',
      'distance': '28 km yakında',
      'timeRemaining': '40 dk açık',
      'attendees': 2,
      'isLive': true,
      'tags': ['Kısa Mola', 'Kahve'],
    },
  ];

  final List<Map<String, dynamic>> scheduledRides = [
    {
      'title': 'Kapadokya Vadileri Hafta Sonu Sürüşü',
      'organizer': 'Kapadokya Riders Kulübü',
      'date': 'Bu Cumartesi, 09:00',
      'meetingPoint': 'Nevşehir Çevre Yolu Opet',
      'pace': 'Orta / Sakin Seyir (80-100 km/s)',
      'attendeeCount': 12,
      'routeDistance': '160 km',
    },
    {
      'title': 'Erciyes Zirve Yaylaları Çadır Kampı',
      'organizer': 'Anadolu Gezginleri',
      'date': 'Gelecek Hafta Sonu (2 Günlük)',
      'meetingPoint': 'Kayseri Meydan',
      'pace': 'Enduro / Viraj Ağırlıklı',
      'attendeeCount': 8,
      'routeDistance': '220 km',
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

  void _showNewSignalDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.amber[800], size: 28),
                  const SizedBox(width: 8),
                  const Text(
                    'Ateş Çemberi Sinyali Yak',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Çevredeki motorculara GPS konumunla birlikte anlık bir buluşma sinyali gönder.',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Buluşma Başlığı',
                  hintText: 'Örn: Çay demlendi, sohbete bekleriz',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Kısa Açıklama',
                  hintText: 'Tam çadır noktası veya konum detayı...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sinyal 2. Fazda anlık haritaya ve çevredeki kullanıcılara yayılacak!')),
                  );
                },
                icon: const Icon(Icons.wifi_tethering),
                label: const Text('Sinyali Yak (Çevreye Duyur)', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Buluşma & Tanışma'),
        backgroundColor: Colors.amber[900],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.local_fire_department), text: 'Canlı Ateş Sinyalleri'),
            Tab(icon: Icon(Icons.groups), text: 'Toplu Sürüşler'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
        onPressed: _showNewSignalDialog,
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Sinyal Yak'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Sekme: Canlı Kamp Ateşi Sinyalleri
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 80),
            itemCount: activeSignals.length,
            itemBuilder: (context, index) {
              final signal = activeSignals[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.amber.shade100,
                            foregroundColor: Colors.amber.shade900,
                            child: Text(signal['hostAvatar'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(signal['host'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                Text(signal['bike'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.circle, size: 8, color: Colors.red),
                                const SizedBox(width: 5),
                                Text(
                                  signal['timeRemaining'],
                                  style: const TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        signal['title'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        signal['description'],
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        children: (signal['tags'] as List<String>)
                            .map((tag) => Chip(
                                  label: Text(tag, style: const TextStyle(fontSize: 11)),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: Colors.grey.shade100,
                                ))
                            .toList(),
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.navigation, size: 16, color: Colors.deepOrange),
                              const SizedBox(width: 4),
                              Text(signal['distance'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${signal['host']} kullanıcısına 'Yola Çıktım' bildirimi gönderildi!")),
                              );
                            },
                            icon: const Icon(Icons.directions_bike, size: 16),
                            label: const Text('Ben de Geliyorum'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 2. Sekme: Planlı Toplu Sürüşler
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 80),
            itemCount: scheduledRides.length,
            itemBuilder: (context, index) {
              final ride = scheduledRides[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
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
                              ride['title'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${ride['attendeeCount']} Motorcu',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Düzenleyen: ${ride['organizer']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 16, color: Colors.blueGrey),
                          const SizedBox(width: 6),
                          Text(ride['date'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.place, size: 16, color: Colors.redAccent),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Buluşma Yeri: ${ride['meetingPoint']}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.speed, size: 16, color: Colors.amber),
                          const SizedBox(width: 6),
                          Text('Tempo: ${ride['pace']} (${ride['routeDistance']})', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.indigo,
                            side: const BorderSide(color: Colors.indigo),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${ride['title']} konvoyuna katıldınız!")),
                            );
                          },
                          icon: const Icon(Icons.group_add, size: 18),
                          label: const Text('Konvoya Katıl'),
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
}