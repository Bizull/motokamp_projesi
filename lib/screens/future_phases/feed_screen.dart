import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'volkan_rider',
      'userImage': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      'bike': 'BMW R1250 GS',
      'location': 'Hasan Dağı Etekleri Kamp Alanı',
      'postImage': 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=800',
      'caption': 'Sislerin arasından zirveye tırmanış... Çadırı kurduk, közde çay hazır. 🏍️⛺🔥',
      'likes': 142,
      'isLiked': false,
      'timeAgo': '2 saat önce',
    },
    {
      'username': 'kampci_cift',
      'userImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      'bike': 'Honda Africa Twin',
      'location': 'Ihlara Vadisi Kanyon Çıkışı',
      'postImage': 'https://images.unsplash.com/photo-1510312305653-8ed496efae75?w=800',
      'caption': 'Vadi virajları sonbaharda bir başka güzel. Akşam kamp ateşi başında sohbete bekleriz!',
      'likes': 89,
      'isLiked': true,
      'timeAgo': '5 saat önce',
    },
    {
      'username': 'enduro_mehmet',
      'userImage': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      'bike': 'Yamaha Tenere 700',
      'location': 'Tuz Gölü Batı Kıyısı',
      'postImage': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800',
      'caption': 'Tuz üzerinde gün batımı sürüşü. Çadırımızı rüzgar almayan tarafa kurduk, rota kusursuzdu.',
      'likes': 210,
      'isLiked': false,
      'timeAgo': 'Dün',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Yol Anıları & Akış'),
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined),
            tooltip: 'Anı Paylaş',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fotoğraf/Video yükleme 2. Fazda eklenecek!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Üst Başlık (Profil Fotoğrafı, Kullanıcı Adı, Motor Modeli ve Konum)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.purple.shade100,
                        child: const Icon(Icons.person, color: Colors.purple),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  post['username'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    post['bike'],
                                    style: TextStyle(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 12, color: Colors.deepOrange),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    post['location'],
                                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // 2. Fotoğraf Alanı
                Container(
                  height: 260,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Image.network(
                    post['postImage'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    ),
                  ),
                ),

                // 3. Etkileşim Butonları (Beğen, Yorum, Rotayı Kaydet)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                          color: post['isLiked'] ? Colors.red : Colors.black87,
                        ),
                        onPressed: () {
                          setState(() {
                            post['isLiked'] = !post['isLiked'];
                            post['likes'] += post['isLiked'] ? 1 : -1;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      TextButton.icon(
                        style: TextButton.styleFrom(foregroundColor: Colors.deepOrange),
                        icon: const Icon(Icons.alt_route, size: 18),
                        label: const Text('Bu Rotayı Al', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${post['location']} rotası kaydedilenlere eklendi!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // 4. Beğeni ve Açıklama Metni
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${post['likes']} kişi beğendi',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black87, fontSize: 13),
                          children: [
                            TextSpan(
                              text: '${post['username']} ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: post['caption']),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post['timeAgo'],
                        style: TextStyle(color: Colors.grey[500], fontSize: 11),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}