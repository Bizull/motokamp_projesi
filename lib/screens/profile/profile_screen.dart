import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'badges_screen.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  final String currentUsername = 'demursuvari'; // Varsayılan oturum açmış kullanıcı

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => isLoading = true);
    final data = await ApiService.fetchUserProfile(currentUsername);
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  void _showAddReviewDialog() {
    final commentController = TextEditingController();
    int selectedScore = 5;
    String selectedActivity = 'Ortak Sürüş';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Row(
                children: [
                  Icon(Icons.verified_user, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Güven Değerlendirmesi Yap', style: TextStyle(fontSize: 18)),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Puan (1 - 5):', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < selectedScore ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 32,
                          ),
                          onPressed: () {
                            setDialogState(() => selectedScore = index + 1);
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedActivity,
                      decoration: const InputDecoration(
                        labelText: 'Nerede / Nasıl Tanıştınız?',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Ortak Sürüş', 'Kamp Ateşi', 'Yol Yardımı', 'Ekipman Paylaşımı']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setDialogState(() => selectedActivity = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Değerlendirmeniz / Referans Notunuz',
                        hintText: 'Örn: Gece sürüşünde arkada artçı desteği sağladı, son derece güvenilir bir sürücü.',
                        border: OutlineInputBorder(),
                      ),
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
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD9531E), foregroundColor: Colors.white),
                  onPressed: () async {
                    if (commentController.text.trim().isEmpty) return;

                    // Test amacıyla başka bir kullanıcı adı (misafir) üzerinden mevcut kullanıcıya güven puanı gönderiyoruz
                    final success = await ApiService.submitTrustReview(
                      reviewerUsername: 'yolcusu_${DateTime.now().millisecond}',
                      targetUsername: currentUsername,
                      score: selectedScore,
                      comment: commentController.text.trim(),
                      activity: selectedActivity,
                    );

                    Navigator.pop(context);
                    if (success) {
                      _loadProfile();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Güven puanı kaydedildi!')),
                      );
                    }
                  },
                  child: const Text('Puanı Kaydet'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFFD9531E))),
      );
    }

    final trustStats = userData?['trustStats'] ?? {};
    final String avgScore = trustStats['averageScore']?.toString() ?? 'Yeni';
    final int totalReviews = trustStats['totalReviews'] ?? 0;
    final List reviews = trustStats['reviews'] ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Sürücü Profili'),
        backgroundColor: const Color(0xFFD9531E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProfile,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.rate_review),
        label: const Text('Güven Puanı Ver (Test)'),
        onPressed: _showAddReviewDialog,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. Profil Başlık Kartı
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 44,
                      backgroundColor: Color(0xFFFDE8E1),
                      child: Icon(Icons.two_wheeler, size: 48, color: Color(0xFFD9531E)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userData?['fullName'] ?? 'Demir Süvari',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@${userData?['username'] ?? 'demursuvari'}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userData?['bio'] ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    const Divider(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProfileInfo(Icons.motorcycle, userData?['motorcycle'] ?? '-'),
                        _buildProfileInfo(Icons.location_on, userData?['city'] ?? '-'),
                        _buildProfileInfo(Icons.bloodtype, userData?['bloodType'] ?? '-', iconColor: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. GÜVEN PUANI VE GÜVENİLİRLİK SKOR KARTI
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.verified, color: Colors.blueAccent, size: 28),
                        const SizedBox(width: 8),
                        const Text(
                          'Topluluk Güven Puanı',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '$avgScore / 5.0',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Bu sürücü $totalReviews kamp/sürüş arkadaşı tarafından doğrulandı ve değerlendirildi.',
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),


            //---------Rozetler Kartı----------
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BadgesScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.military_tech, color: Colors.amber, size: 26),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Seviye ${userData?['level'] ?? 1} Yol Gezgini',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                Text(
                                  '${userData?['xp'] ?? 120} / 500 XP',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'Rozetler',
                                  style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // İlerleme Çubuğu (XP Bar)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: ((userData?['xp'] ?? 120) / 500).clamp(0.0, 1.0),
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD9531E)),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

            // 3. GELEN GÜVEN DEĞERLENDİRMELERİ LİSTESİ
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sürüş & Kamp Referansları ($totalReviews)',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            reviews.isEmpty
                ? const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Henüz referans yorumu eklenmemiş.\nSağ alttaki yeşil butona basarak ilk referansı siz ekleyin!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final rev = reviews[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade50,
                            child: const Icon(Icons.person, color: Colors.blueAccent),
                          ),
                          title: Row(
                            children: [
                              Text(
                                rev['reviewer']?['username'] ?? 'Gezgin',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  rev['activity'] ?? 'Sürüş',
                                  style: TextStyle(fontSize: 10, color: Colors.orange.shade900),
                                ),
                              ),
                              const Spacer(),
                              ...List.generate(
                                rev['score'] ?? 5,
                                (i) => const Icon(Icons.star, color: Colors.amber, size: 14),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(rev['comment'] ?? ''),
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String text, {Color? iconColor}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor ?? const Color(0xFFD9531E)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}