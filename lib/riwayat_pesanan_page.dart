import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() =>
      _RiwayatPesananPageState();
}

class _RiwayatPesananPageState
    extends State<RiwayatPesananPage> {
  static const Color cokelat = Color(0xFF8B5E3C);
  static const Color cokelatGelap = Color(0xFF5D321D);
  static const Color krem = Color(0xFFFFF8F0);

  List<Map<String, dynamic>> riwayatPesanan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  // Membaca riwayat dari penyimpanan lokal
  Future<void> _loadRiwayat() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> data =
          prefs.getStringList('riwayat_pesanan') ?? [];

      final List<Map<String, dynamic>> hasil = [];

      for (final item in data) {
        try {
          final decoded = jsonDecode(item);

          if (decoded is Map<String, dynamic>) {
            hasil.add(decoded);
          }
        } catch (_) {
          // Lewati data yang formatnya tidak valid.
        }
      }

      if (!mounted) return;

      setState(() {
        riwayatPesanan = hasil;
        isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  // Format angka menjadi Rupiah
  String _formatRupiah(dynamic value) {
    final int angka =
        int.tryParse(value?.toString() ?? '0') ?? 0;

    final String teks = angka.toString();
    final StringBuffer hasil = StringBuffer();

    for (int i = 0; i < teks.length; i++) {
      if (i > 0 && (teks.length - i) % 3 == 0) {
        hasil.write('.');
      }

      hasil.write(teks[i]);
    }

    return 'Rp${hasil.toString()}';
  }

  // Format tanggal pesanan
  String _formatTanggal(dynamic value) {
    if (value == null) return '-';

    final tanggal = DateTime.tryParse(value.toString());

    if (tanggal == null) return value.toString();

    final waktu = tanggal.toLocal();

    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final jam = waktu.hour.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');

    return '${waktu.day} ${bulan[waktu.month - 1]} '
        '${waktu.year}, $jam:$menit';
  }

  // Warna status pembayaran/pesanan
  Color _warnaStatus(String status) {
    final teks = status.toLowerCase();

    if (teks.contains('menunggu')) {
      return Colors.orange.shade800;
    }

    if (teks.contains('batal') || teks.contains('gagal')) {
      return Colors.red.shade700;
    }

    if (teks.contains('berhasil') ||
        teks.contains('selesai') ||
        teks.contains('terkonfirmasi')) {
      return Colors.green.shade700;
    }

    return cokelatGelap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: krem,
      appBar: AppBar(
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: cokelatGelap,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _loadRiwayat,
            tooltip: 'Muat ulang riwayat',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: cokelat,
              ),
            )
          : riwayatPesanan.isEmpty
              ? _buildKosong()
              : RefreshIndicator(
                  color: cokelat,
                  onRefresh: _loadRiwayat,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: riwayatPesanan.length,
                    itemBuilder: (context, index) {
                      final pesanan = riwayatPesanan[index];

                      return _buildKartuPesanan(pesanan);
                    },
                  ),
                ),
    );
  }

  // Kartu untuk setiap pesanan
  Widget _buildKartuPesanan(
    Map<String, dynamic> pesanan,
  ) {
    final String metode =
        pesanan['metodePembayaran']?.toString() ?? 'COD';

    final String status =
        pesanan['status']?.toString() ?? 'Pesanan dibuat';

    final int jumlah =
        int.tryParse(pesanan['jumlah']?.toString() ?? '0') ?? 0;

    final String tanggal = _formatTanggal(pesanan['tanggal']);

    final String alamat =
        pesanan['alamat']?.toString() ?? '-';

    final List<dynamic> items =
        pesanan['items'] is List ? pesanan['items'] as List : [];

    final int total =
        int.tryParse(pesanan['total']?.toString() ?? '0') ?? 0;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header pesanan
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cokelat.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: cokelatGelap,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pesanan Zia Bakery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: cokelatGelap,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        tanggal,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            // Daftar kue
            const Text(
              'Detail Produk',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: cokelatGelap,
              ),
            ),
            const SizedBox(height: 10),

            if (items.isEmpty)
              const Text(
                'Detail produk tidak tersedia.',
                style: TextStyle(color: Colors.grey),
              )
            else
              ...items.map((item) {
                if (item is! Map) {
                  return const SizedBox.shrink();
                }

                final String nama =
                    item['nama']?.toString() ?? 'Kue';

                final int qty = int.tryParse(
                      item['jumlah']?.toString() ?? '0',
                    ) ??
                    0;

                final int subtotal = int.tryParse(
                      item['subtotal']?.toString() ?? '0',
                    ) ??
                    0;

                final String gambar =
                    item['gambar']?.toString() ?? '';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: krem,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: gambar.isEmpty
                            ? const Icon(
                                Icons.cake,
                                color: cokelat,
                              )
                            : Image.asset(
                                gambar,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) {
                                  return const Icon(
                                    Icons.cake,
                                    color: cokelat,
                                  );
                                },
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: cokelatGelap,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$qty item',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatRupiah(subtotal),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cokelat,
                        ),
                      ),
                    ],
                  ),
                );
              }),

            const Divider(height: 20),

            _buildInfo('Jumlah Produk', '$jumlah item'),
            const SizedBox(height: 10),
            _buildInfo('Pembayaran', metode),
            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Status Pesanan',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    status,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _warnaStatus(status),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Alamat Pengiriman',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    alamat,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cokelatGelap,
                    ),
                  ),
                ),
                Text(
                  _formatRupiah(total),
                  style: const TextStyle(
                    color: cokelatGelap,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 90,
              color: cokelat.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Riwayat Pesanan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cokelatGelap,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pesanan yang tersimpan akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _loadRiwayat,
              icon: const Icon(Icons.refresh),
              label: const Text('Muat Ulang'),
              style: OutlinedButton.styleFrom(
                foregroundColor: cokelatGelap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}