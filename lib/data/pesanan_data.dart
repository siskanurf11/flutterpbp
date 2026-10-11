
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/pesanan.dart';

class PesananData {
  // Nama kunci untuk penyimpanan riwayat pesanan.
  static const String _key = 'riwayat_pesanan_zia_bakery';

  // Mengambil seluruh riwayat pesanan yang tersimpan.
  static Future<List<Pesanan>> ambilSemua() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);

    if (data == null || data.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(data);

      return jsonList.map((item) {
        return Pesanan.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // Menyimpan pesanan baru ke riwayat.
  static Future<void> simpan(Pesanan pesanan) async {
    final List<Pesanan> semuaPesanan = await ambilSemua();

    // Pesanan terbaru diletakkan di urutan paling atas.
    semuaPesanan.insert(0, pesanan);

    final prefs = await SharedPreferences.getInstance();

    final String dataJson = jsonEncode(
      semuaPesanan.map((item) => item.toJson()).toList(),
    );

    await prefs.setString(_key, dataJson);
  }
}
