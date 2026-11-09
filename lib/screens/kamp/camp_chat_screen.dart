import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class CampChatScreen extends StatefulWidget {
  const CampChatScreen({super.key});

  @override
  State<CampChatScreen> createState() => _CampChatScreenState();
}

class _CampChatScreenState extends State<CampChatScreen> {
  List<Map<String, dynamic>> activeCampfires = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFires();
  }

  Future<void> _loadFires() async {
    setState(() => isLoading = true);
    final fires = await ApiService.fetchFires();
    setState(() {
      activeCampfires = fires;
      isLoading = false;
    });
  }

  void _openNewCampfireModal() {
    final locationController = TextEditingController();
    final topicController = TextEditingController();
    final descController = TextEditingController();

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
                  const Icon(Icons.fireplace, color: Colors.orange, size: 28),
                  const SizedBox(width: 8),
                  const Text(
                    'Kamp Ateşi Daveti Başlat',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Bulunduğun Kamp Noktası *',
                  hintText: 'Örn: Hasan Dağı 2. Viraj çeşme yanı',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: topicController,
                decoration: InputDecoration(
                  labelText: 'Ateş Başı Konusu / Davet *',
                  hintText: 'Örn: Közde patates & çay var',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Detaylar (Ulaşım, odun vb.)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9531E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  if (locationController.text.isEmpty || topicController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lütfen konum ve başlık girin.')),
                    );
                    return;
                  }

                  Navigator.pop(context);

                  final success = await ApiService.createFire(
                    host: 'Demir Süvari',
                    location: locationController.text,
                    topic: topicController.text,
                    description: descController.text,
                    woodStatus: 'Mevcut',
                  );

                  if (success) {
                    _loadFires(); // Listeyi sunucudan tazele
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ateş backend sunucusuna kaydedildi! 🔥')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sunucuya bağlanılamadı!')),
                    );
                  }
                },
                icon: const Icon(Icons.whatshot),
                label: const Text('Ateşi Yak & Sunucuya Gönder', style: TextStyle(fontWeight: FontWeight.bold)),
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
        title: const Text('Ateş Başı Sohbet & Davet'),
        backgroundColor: const Color(0xFFD9531E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFires,
            tooltip: 'Yenile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD9531E),
        foregroundColor: Colors.white,
        onPressed: _openNewCampfireModal,
        icon: const Icon(Icons.whatshot),
        label: const Text('Ateş Yak'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFD9531E)))
          : activeCampfires.isEmpty
              ? const Center(child: Text('Henüz yanan bir ateş yok veya sunucuya erişilemiyor.'))
              : RefreshIndicator(
                  onRefresh: _loadFires,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
                    itemCount: activeCampfires.length,
                    itemBuilder: (context, index) {
                      final fire = activeCampfires[index];
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
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFFFDE8E1),
                                    child: Icon(Icons.fireplace, color: Color(0xFFD9531E)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fire['host'] ?? 'Gezgin',
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                        ),
                                        Text(
                                          fire['location'] ?? '',
                                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.orange.shade200),
                                    ),
                                    child: Text(
                                      fire['timeAgo'] ?? 'Yeni',
                                      style: TextStyle(fontSize: 11, color: Colors.orange.shade900, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                fire['topic'] ?? '',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                fire['description'] ?? '',
                                style: TextStyle(fontSize: 13, color: Colors.grey[800]),
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