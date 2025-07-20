import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api';

  static Future<List<Map<String, dynamic>>> getKullaniciListesi() async {
    final url = Uri.parse('$_baseUrl/kullanici_listesi/');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Kullanıcı listesi alınamadı: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/kayit/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Kayıt başarılı'};
      } else {
        try {
          final decoded = json.decode(response.body);
          return {
            'success': false,
            'message': decoded['message'] ?? 'Bir hata oluştu',
          };
        } catch (e) {
          return {
            'success': false,
            'message':
                'Sunucudan geçersiz yanıt alındı: ${response.statusCode}',
          };
        }
      }
    } catch (e) {
      return {'success': false, 'message': 'Sunucuya ulaşılamadı'};
    }
  }

  static Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/giris/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Giriş başarılı'};
    } else {
      return {
        'success': false,
        'message': json.decode(response.body)['message'] ?? 'Hata oluştu',
      };
    }
  }
}
