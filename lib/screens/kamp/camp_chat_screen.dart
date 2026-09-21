import 'package:flutter/material.dart';

class CampChatScreen extends StatefulWidget {
  const CampChatScreen({super.key});

  @override
  State<CampChatScreen> createState() => _CampChatScreenState();
}

class _CampChatScreenState extends State<CampChatScreen> {
  final List<Map<String, dynamic>> activeCampfires = [
    {
      'host': 'Mert & Canan',
      'location': 'Hasan Dağı Yılkant Yaylası',
      'topic': 'Közde Kahve & Gökyüzü İzleme',
      'description': 'Çadırları kurduk, ateşimiz canlı. Yıldızlar çok net, kamp çayımız hazır. Rotadan geçen herkesi bekleriz!',
      'timeAgo': '15 dk önce yandı',
      'attendees': 3,
      'isFireBurning': true,
      'woodStatus': 'Bol miktarda odun var',
    },
    {
      'host': 'Murat Gezgin',
      'location': 'Erciyes Tekir Göleti Kenarı',
      'topic': 'Rüzgarsız Kuytu Köşe & Sohbet',
      'description': 'Gölet kenarında rüzgar kesen taraftayız. Kamp ateşi başındayız, gitar getiren olursa çok tatlı olur.',
      'timeAgo': '1 saat önce yandı',
      'attendees': 2,
      'isFireBurning': true,
      'woodStatus': 'Kendi getirdiğimiz meşe odunları',
    },
    {
      'host': 'Doğa Severler Ekibi',
      'location': 'Kapadokya Vadi Girişi',
      'topic': 'Sabah Balonları Öncesi Kamp',
      'description': 'Yarın sabah gün doğumunda balonları izlemek için buradayız. Ateş başı toplanıyoruz.',
      'timeAgo': '2 saat önce yandı',
      'attendees': 5,
      'isFireBurning': true,
      'woodStatus': 'Odun yeterli',
    },
  ];

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
              const SizedBox(height: 8),
              const Text(
                'Çadır kurduğun noktayı ve ateş başı sohbet davetini diğer gezginlerle paylaş.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
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
                  hintText: 'Örn: Közde patates & çay var, bekleriz',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Detaylar (Ulaşım, odun vb.)',
                  hintText: 'Çadırın yeri, yol durumu veya gelenlerin getirebileceği şeyler...',
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
                onPressed: () {
                  if (locationController.text.isEmpty || topicController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lütfen kamp yeri ve davet konusunu girin.')),
                    );
                    return;
                  }
                  setState(() {
                    activeCampfires.insert(0, {
                      'host': 'Demir Süvari (Sen)',
                      'location': locationController.text,
                      'topic': topicController.text,
                      'description': descController.text.isEmpty ? 'Ateşimiz yanıyor, bekliyoruz.' : descController.text,
                      'timeAgo': 'Az önce yandı',
                      'attendees': 1,
                      'isFireBurning': true,
                      'woodStatus': 'Mevcut',
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ateş başı davetin çevreye yayınlandı! 🔥')),
                  );
                },
                icon: const Icon(Icons.whatshot),
                label: const Text('Ateşi Yak & Davet Et', style: TextStyle(fontWeight: FontWeight.bold)),
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
        backgroundColor: const Color(0xFFD9531E), // Köz turuncusu
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD9531E),
        foregroundColor: Colors.white,
        onPressed: _openNewCampfireModal,
        icon: const Icon(Icons.whatshot),
        label: const Text('Ateş Yak'),
      ),
      body: ListView.builder(
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
                              fire['host'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    fire['location'],
                                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
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
                          fire['timeAgo'],
                          style: TextStyle(fontSize: 11, color: Colors.orange.shade900, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    fire['topic'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    fire['description'],
                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.forest, size: 15, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        'Odun/Yakıt Durumu: ${fire['woodStatus']}',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${fire['attendees']} kişi ateşte',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B4332),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${fire['host']} çadırına selam gönderildi, yola çıkılıyor!")),
                          );
                        },
                        icon: const Icon(Icons.emoji_people, size: 16),
                        label: const Text('Çay İçmeye Geliyorum'),
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