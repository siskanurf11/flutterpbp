import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/kue.dart';

class CheckoutPage extends StatefulWidget {
  final Map<Kue, int> cart;
  final VoidCallback onOrderSuccess;

  const CheckoutPage({
    super.key,
    required this.cart,
    required this.onOrderSuccess,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController addressController =
      TextEditingController();

  String paymentMethod = 'COD';
  bool isSaving = false;

  static const Color darkBrown = Color(0xFF5D321D);
  static const Color brown = Color(0xFF8B5E3C);
  static const Color lightBrown = Color(0xFFE8D5C4);
  static const Color backgroundBrown = Color(0xFFFFF8F1);

  // =========================================================
  // HITUNG TOTAL
  // =========================================================

  int getTotal() {
    int total = 0;

    widget.cart.forEach((cake, quantity) {
      total += cake.price * quantity;
    });

    return total;
  }

  // =========================================================
  // FORMAT RUPIAH
  // =========================================================

  String formatRupiah(int value) {
    final priceString = value.toString();
    String result = '';

    for (int i = 0; i < priceString.length; i++) {
      if (i > 0 && (priceString.length - i) % 3 == 0) {
        result += '.';
      }

      result += priceString[i];
    }

    return 'Rp$result';
  }

  // =========================================================
  // JUMLAH PRODUK
  // =========================================================

  int getTotalItems() {
    int total = 0;

    for (final quantity in widget.cart.values) {
      total += quantity;
    }

    return total;
  }

  // =========================================================
  // SIMPAN RIWAYAT PESANAN
  // =========================================================

  Future<void> saveOrderToHistory({
    required String status,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> history =
        prefs.getStringList('riwayat_pesanan') ?? [];

    final List<Map<String, dynamic>> items =
        widget.cart.entries.map((entry) {
      final cake = entry.key;
      final quantity = entry.value;

      return {
        'nama': cake.name,
        'jumlah': quantity,
        'harga': cake.price,
        'subtotal': cake.price * quantity,
        'gambar': cake.image,
      };
    }).toList();

    final order = <String, dynamic>{
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'tanggal': DateTime.now().toIso8601String(),
      'alamat': addressController.text.trim(),
      'metodePembayaran': paymentMethod,
      'status': status,
      'jumlah': getTotalItems(),
      'total': getTotal(),
      'items': items,
    };

    history.insert(0, jsonEncode(order));

    final saved = await prefs.setStringList(
      'riwayat_pesanan',
      history,
    );

    if (!saved) {
      throw Exception('Riwayat pesanan gagal disimpan.');
    }
  }

  // =========================================================
  // CHECKOUT BERHASIL
  // =========================================================

  Future<void> orderNow() async {
    if (isSaving) return;

    if (widget.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang kamu masih kosong.'),
          backgroundColor: darkBrown,
        ),
      );
      return;
    }

    if (addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan masukkan alamat terlebih dahulu.',
          ),
          backgroundColor: darkBrown,
        ),
      );
      return;
    }

    // QRIS memerlukan konfirmasi pembayaran.
    // Tombol ini hanya mencatat konfirmasi manual dari pembeli,
    // bukan verifikasi transaksi otomatis.
    final String status = paymentMethod == 'COD'
        ? 'Menunggu pembayaran saat diterima'
        : 'Menunggu verifikasi pembayaran QRIS';

    setState(() {
      isSaving = true;
    });

    try {
      await saveOrderToHistory(status: status);

      if (!mounted) return;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Pesanan Berhasil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: lightBrown,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 40,
                    color: brown,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  paymentMethod == 'COD'
                      ? 'Pesanan berhasil dibuat. Pembayaran dilakukan saat pesanan diterima.'
                      : 'Pesanan tersimpan. Pembayaran QRIS perlu dikonfirmasi.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Total: ${formatRupiah(getTotal())}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: brown,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Jumlah produk: ${getTotalItems()}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Metode: $paymentMethod',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: darkBrown,
                  ),
                ),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Stok diperbarui setelah pesanan berhasil
                    widget.onOrderSuccess();

                    Navigator.pop(dialogContext);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Lihat Riwayat Nanti',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan pesanan: $e'),
          backgroundColor: darkBrown,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  // =========================================================
  // WIDGET INFORMASI
  // =========================================================

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
    );
  }

  Widget buildOrderItems() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: widget.cart.entries.map((entry) {
          final cake = entry.key;
          final quantity = entry.value;
          final subtotal = cake.price * quantity;

          return Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: backgroundBrown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    cake.image,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.cake,
                        size: 35,
                        color: brown,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cake.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: darkBrown,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${cake.getFormattedPrice()} x $quantity',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatRupiah(subtotal),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: brown,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildPaymentMethod() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          RadioListTile<String>(
            value: 'COD',
            groupValue: paymentMethod,
            activeColor: brown,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                paymentMethod = value;
              });
            },
            title: const Text(
              'COD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            subtitle: const Text(
              'Bayar saat pesanan diterima',
            ),
            secondary: const Icon(
              Icons.payments_outlined,
              color: brown,
            ),
          ),
          const Divider(
            height: 1,
            indent: 15,
            endIndent: 15,
          ),
          RadioListTile<String>(
            value: 'QRIS',
            groupValue: paymentMethod,
            activeColor: brown,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                paymentMethod = value;
              });
            },
            title: const Text(
              'QRIS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            subtitle: const Text(
              'Bayar menggunakan QRIS',
            ),
            secondary: const Icon(
              Icons.qr_code_2,
              color: brown,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQris() {
    if (paymentMethod != 'QRIS') {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Text(
            'Scan QRIS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Scan kode QR untuk melakukan pembayaran.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 280,
            height: 280,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: lightBrown,
                width: 2,
              ),
            ),
            child: Image.asset(
              'assets/images/QRIS_ZiaBakery.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 50,
                        color: brown,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gambar QRIS tidak ditemukan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Total: ${formatRupiah(getTotal())}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: brown,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pastikan pembayaran telah dilakukan. Status pembayaran belum diverifikasi secara otomatis.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jumlah Produk',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${getTotalItems()} item',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Metode Pembayaran',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
              ),
              Text(
                formatRupiah(getTotal()),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBrown,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: brown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Pesanan Kamu'),
            const SizedBox(height: 12),
            buildOrderItems(),

            const SizedBox(height: 25),

            buildSectionTitle('Alamat Pengiriman'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: addressController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Masukkan alamat lengkap...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 55),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: brown,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            buildSectionTitle('Metode Pembayaran'),
            const SizedBox(height: 12),
            buildPaymentMethod(),

            if (paymentMethod == 'QRIS') ...[
              const SizedBox(height: 18),
              buildQris(),
            ],

            const SizedBox(height: 25),

            buildSummary(),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isSaving ? null : orderNow,
                icon: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        paymentMethod == 'QRIS'
                            ? Icons.qr_code_2
                            : Icons.shopping_bag_outlined,
                      ),
                label: Text(
                  isSaving
                      ? 'Menyimpan Pesanan...'
                      : 'Pesan Sekarang',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}