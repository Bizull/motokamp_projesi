import 'package:flutter/material.dart';
import 'badges_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Zorunlu Bilgiler
  String name = 'Muhammed Emin Dilek';
  int age = 35;
  String gender = 'Erkek'; // Erkek / Kadın / Belirtmek İstemiyor
  String city = 'Kayseri / Aksaray';

  // Opsiyonel (Keyfi) Bilgiler
  String bike = 'Yamaha Tenere 700';
  String ridingLevel = 'İleri Düzey (Enduro & Viraj)'; // Başlangıç / Orta / İleri
  String campingExp = 'Deneyimli (Kış Kampı & Çadır)'; // Az / Orta / Deneyimli
  String bio = 'Rüzgar nereye biz oraya. Hafta sonları çadır ve viraj peşindeyiz.';
  Widget _buildMiniBadge(IconData icon, String label, Color color) {
  return Column(
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, size: 20, color: color),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    ],
  );
}

  void _editProfileDialog() {
    final nameController = TextEditingController(text: name);
    final ageController = TextEditingController(text: age.toString());
    final cityController = TextEditingController(text: city);
    final bikeController = TextEditingController(text: bike);
    final bioController = TextEditingController(text: bio);

    String tempGender = gender;
    String tempRidingLevel = ridingLevel;
    String tempCampingExp = campingExp;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Profili Düzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ZORUNLU BİLGİLER (*)',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Ad Soyad / Lakap *'),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Yaş *'),
                ),
                DropdownButtonFormField<String>(
                  value: tempGender,
                  decoration: const InputDecoration(labelText: 'Cinsiyet *'),
                  items: const [
                    DropdownMenuItem(value: 'Erkek', child: Text('Erkek')),
                    DropdownMenuItem(value: 'Kadın', child: Text('Kadın')),
                    DropdownMenuItem(value: 'Belirtmek İstemiyor', child: Text('Belirtmek İstemiyor')),
                  ],
                  onChanged: (val) => setDialogState(() => tempGender = val!),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'Şehir *'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'KEYFİ DETAYLAR (İsteğe Bağlı)',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: bikeController,
                  decoration: const InputDecoration(labelText: 'Motosiklet Modeli'),
                ),
                DropdownButtonFormField<String>(
                  value: tempRidingLevel,
                  decoration: const InputDecoration(labelText: 'Sürüş Seviyesi'),
                  items: const [
                    DropdownMenuItem(value: 'Başlangıç', child: Text('Başlangıç')),
                    DropdownMenuItem(value: 'Orta Düzey', child: Text('Orta Düzey')),
                    DropdownMenuItem(value: 'İleri Düzey (Enduro & Viraj)', child: Text('İleri Düzey (Enduro & Viraj)')),
                  ],
                  onChanged: (val) => setDialogState(() => tempRidingLevel = val!),
                ),
                DropdownButtonFormField<String>(
                  value: tempCampingExp,
                  decoration: const InputDecoration(labelText: 'Kamp Tecrübesi'),
                  items: const [
                    DropdownMenuItem(value: 'Yeni Başlayan', child: Text('Yeni Başlayan')),
                    DropdownMenuItem(value: 'Orta (Yaz Kampçısı)', child: Text('Orta (Yaz Kampçısı)')),
                    DropdownMenuItem(value: 'Deneyimli (Kış Kampı & Çadır)', child: Text('Deneyimli (Kış Kampı & Çadır)')),
                  ],
                  onChanged: (val) => setDialogState(() => tempCampingExp = val!),
                ),
                TextField(
                  controller: bioController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Hakkımda / Biyografi'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
              onPressed: () {
                if (nameController.text.isEmpty || ageController.text.isEmpty || cityController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lütfen zorunlu alanları (*) doldurunuz.')),
                  );
                  return;
                }
                setState(() {
                  name = nameController.text;
                  age = int.tryParse(ageController.text) ?? age;
                  gender = tempGender;
                  city = cityController.text;
                  bike = bikeController.text;
                  ridingLevel = tempRidingLevel;
                  campingExp = tempCampingExp;
                  bio = bioController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil başarıyla güncellendi!')),
                );
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Motorcu Profili'),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfileDialog,
            tooltip: 'Profili Düzenle',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profil Başlığı
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.deepOrange.shade100,
                    child: const Icon(Icons.two_wheeler, size: 50, color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$age Yaş • $gender', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                const SizedBox(width: 8),
                const Icon(Icons.location_on, size: 14, color: Colors.deepOrange),
                Text(city, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
            const SizedBox(height: 12),
            if (bio.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black87, fontSize: 13),
                ),
              ),
            const SizedBox(height: 16),

            // Keyfi/Opsiyonel Bilgilerin Gösterimi (Rozet/Bilgi Kartları)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sürüş & Kamp Yetkinlikleri',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const Divider(height: 20),
                    _buildInfoRow(Icons.two_wheeler, 'Motosiklet', bike.isEmpty ? 'Girilmedi' : bike),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.speed, 'Sürüş Yetkinliği', ridingLevel),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.cabin, 'Kamp Tecrübesi', campingExp),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Rozet Vitrini Kartı
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shield, color: Colors.amber, size: 22),
                            const SizedBox(width: 8),
                            const Text(
                              'Seviye 3: Yol Dostu',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BadgesScreen()),
                            );
                          },
                          child: const Text('Tümünü Gör (6)', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMiniBadge(Icons.local_fire_department, 'İlk Ateş', Colors.deepOrange),
                        _buildMiniBadge(Icons.handshake, 'Kaynaşma', Colors.amber),
                        _buildMiniBadge(Icons.groups, 'Sosyallik', Colors.teal),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Aktivite Özeti
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.local_fire_department, color: Colors.amber),
                    title: const Text('Yaktığım Ateşler'),
                    trailing: const Text('3 Kez', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.alt_route, color: Colors.deepOrange),
                    title: const Text('Kaydedilen Rotalar'),
                    trailing: const Text('5 Rota', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}