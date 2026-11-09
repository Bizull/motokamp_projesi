import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000/api';
    }
    return 'http://10.0.2.2:3000/api';
  }

  // --- ATEŞ BAŞI İŞLEMLERİ ---

  static Future<List<Map<String, dynamic>>> fetchFires() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/fires'));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['success'] == true) {
          final List<dynamic> data = decoded['data'];
          return data.map((e) => Map<String, dynamic>.from(e)).toList();
        }
      }
      return [];
    } catch (e) {
      debugPrint('Ateş verisi çekilirken hata: $e');
      return [];
    }
  }

  static Future<bool> createFire({
    required String host,
    required String location,
    required String topic,
    required String description,
    required String woodStatus,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/fires'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'host': host,
          'location': location,
          'topic': topic,
          'description': description,
          'woodStatus': woodStatus,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      debugPrint('Ateş yakma isteğinde hata: $e');
      return false;
    }
  }

  // --- KULLANICI & GÜVEN PUANI İŞLEMLERİ ---

  // 1. Profil Bilgilerini ve Güven Skorunu Getir (Yoksa varsayılan profili otomatik oluşturur)
  static Future<Map<String, dynamic>?> fetchUserProfile(String username) async {
    try {
      // Önce kullanıcının veritabanında var olmasını garantiye alalım (upsert)
      await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'fullName': 'Demir Süvari',
          'motorcycle': 'Yamaha Tenere 700',
          'city': 'İzmir / Manisa',
          'bloodType': '0 Rh+',
          'bio': 'Dağ rotaları, kamp ateşi ve viraj tutkunu.',
        }),
      );

      // Profil ve değerlendirme detaylarını çekelim
      final response = await http.get(Uri.parse('$baseUrl/users/$username'));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['success'] == true) {
          return Map<String, dynamic>.from(decoded['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Profil çekme hatası: $e');
      return null;
    }
  }

  // 2. Bir Kullanıcıya Güven Değerlendirmesi Bırak
  static Future<bool> submitTrustReview({
    required String reviewerUsername,
    required String targetUsername,
    required int score,
    required String comment,
    required String activity,
  }) async {
    try {
      // 1. Puanı veren test kullanıcısı yoksa otomatik oluştur
      await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': reviewerUsername,
          'fullName': 'Sürüş Arkadaşı ($reviewerUsername)',
          'motorcycle': 'Honda Africa Twin',
          'city': 'Manisa',
        }),
      );

      // 2. Değerlendirmeyi gönder
      final response = await http.post(
        Uri.parse('$baseUrl/trust-reviews'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reviewerUsername': reviewerUsername,
          'targetUsername': targetUsername,
          'score': score,
          'comment': comment,
          'activity': activity,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      debugPrint('Güven değerlendirmesi hatası: $e');
      return false;
    }
  }
  
}