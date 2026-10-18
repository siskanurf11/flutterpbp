
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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  static const Color darkBrown = Color(0xFF5D321D);
  static const Color brown = Color(0xFF8B5E3C);
  static const Color lightBrown = Color(0xFFE8D5C4);
  static const Color backgroundBrown = Color(0xFFFFF8F1);

  String metodePengambilan = 'Ambil di Toko';
  String paymentMethod = 'Bayar di Toko';

  DateTime? selectedPickupDate;
  String? selectedPickupTime;

  bool isSaving = false;

  final List<String> pickupTimes = [
    '09.00 - 10.00',
    '10.00 - 11.00',
    '11.00 - 12.00',
    '12.00 - 13.00',
    '13.00 - 14.00',
    '14.00 - 15.00',
    '15.00 - 16.00',
    '16.00 - 17.00',
  ];

  bool get isPickup => metodePengambilan == 'Ambil di Toko';

  @override
  void dispose() {
    addressController.dispose();
    noteController.dispose();
    super.dispose();
  }

  int getTotal() {
    int total = 0;

    for (final entry in widget.cart.entries) {
      total += entry.key.price * entry.value;
    }

    return total;
  }

  int getTotalItems() {
    int total = 0;

    for (final quantity in widget.cart.values) {
      total += quantity;
    }

    return total;
  }

  String formatRupiah(int value) {
    final String number = value.toString();
    final StringBuffer result = StringBuffer();

    for (int i = 0; i < number.length; i++) {
      result.write(number[i]);

      final int remaining = number.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        result.write('.');
      }
    }

    return 'Rp$result';
  }

  String formatTanggal(DateTime date) {
    const List<String> namaBulan = [
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

    return '${date.day} ${namaBulan[date.month - 1]} ${date.year}';
  }

  void ubahMetodePengambilan(String value) {
    setState(() {
      metodePengambilan = value;

      if (value == 'Ambil di Toko') {
        paymentMethod = 'Bayar di Toko';
      } else {
        paymentMethod = 'COD';
      }
    });
  }

  Future<void> pilihTanggalPengambilan() async {
    final DateTime sekarang = DateTime.now();

    final DateTime hariIni = DateTime(
      sekarang.year,
      sekarang.month,
      sekarang.day,
    );

    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: selectedPickupDate ?? hariIni,
      firstDate: hariIni,
      lastDate: DateTime(sekarang.year + 1, 12, 31),
      helpText: 'Pilih tanggal pengambilan',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: brown,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: darkBrown,
            ),
          ),
          child: child!,
        );
      },
    );

    if (tanggal != null && mounted) {
      setState(() {
        selectedPickupDate = tanggal;
      });
    }
  }

  Future<void> saveOrderToHistory({
    required String status,
  }) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    final List<String> history =
        prefs.getStringList('riwayat_pesanan') ?? [];

    final List<Map<String, dynamic>> items =
        widget.cart.entries.map((entry) {
      final Kue cake = entry.key;
      final int quantity = entry.value;

      return <String, dynamic>{
        'nama': cake.name,
        'jumlah': quantity,
        'harga': cake.price,
        'subtotal': cake.price * quantity,
        'gambar': cake.image,
      };
    }).toList();

    final Map<String, dynamic> order = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'tanggal': DateTime.now().toIso8601String(),
      'metodePengambilan': metodePengambilan,
      'metodePembayaran': paymentMethod,
      'alamat': isPickup ? '' : addressController.text.trim(),
      'catatan': noteController.text.trim(),
      'status': status,
      'jumlah': getTotalItems(),
      'total': getTotal(),
      'items': items,
      'tanggalPengambilan': isPickup
          ? selectedPickupDate!.toIso8601String()
          : '',
      'waktuPengambilan': isPickup ? selectedPickupTime! : '',
    };

    history.insert(0, jsonEncode(order));

    final bool saved = await prefs.setStringList(
      'riwayat_pesanan',
      history,
    );

    if (!saved) {
      throw Exception('Pesanan gagal disimpan.');
    }
  }

  Future<void> orderNow() async {
    if (isSaving) return;

    if (widget.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang masih kosong.'),
        ),
      );
      return;
    }

    if (!isPickup && addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alamat pengiriman wajib diisi.'),
        ),
      );
      return;
    }

    if (isPickup && selectedPickupDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih tanggal pengambilan.'),
        ),
      );
      return;
    }

    if (isPickup && selectedPickupTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih waktu pengambilan.'),
        ),
      );
      return;
    }

    String status;

    if (paymentMethod == 'COD') {
      status = 'Menunggu pembayaran saat pesanan diterima';
    } else if (paymentMethod == 'QRIS') {
      status = 'Menunggu verifikasi pembayaran QRIS';
    } else {
      status = 'Menunggu pembayaran saat diambil di toko';
    }

    setState(() {
      isSaving = true;
    });

    try {
      await saveOrderToHistory(status: status);

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: const Text(
              'Pesanan Berhasil',
              style: TextStyle(
                color: darkBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pesanan kamu berhasil dibuat.',
                  ),
                  const SizedBox(height: 12),
                  Text('Total: ${formatRupiah(getTotal())}'),
                  Text('Jumlah produk: ${getTotalItems()}'),
                  Text('Cara menerima: $metodePengambilan'),
                  Text('Pembayaran: $paymentMethod'),
                  if (isPickup) ...[
                    Text(
                      'Tanggal: ${formatTanggal(selectedPickupDate!)}',
                    ),
                    Text('Waktu: $selectedPickupTime'),
                  ] else ...[
                    Text(
                      'Alamat: ${addressController.text.trim()}',
                    ),
                  ],
                  if (noteController.text.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Catatan: ${noteController.text.trim()}',
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: brown,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Selesai'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      widget.onOrderSuccess();
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan pesanan: $e'),
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

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: darkBrown,
        ),
      ),
    );
  }

  Widget buildOrderItems() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: widget.cart.entries.map((entry) {
          final Kue cake = entry.key;
          final int quantity = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    cake.image,
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 65,
                        height: 65,
                        color: lightBrown,
                        child: const Icon(
                          Icons.cake,
                          color: brown,
                        ),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkBrown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${cake.getFormattedPrice()} x $quantity',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatRupiah(cake.price * quantity),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: brown,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildMetodePengambilan() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          RadioListTile<String>(
            value: 'Ambil di Toko',
            groupValue: metodePengambilan,
            activeColor: brown,
            title: const Text(
              'Ambil di Toko',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            subtitle: const Text(
              'Datang langsung untuk mengambil pesanan',
            ),
            secondary: const Icon(
              Icons.storefront,
              color: brown,
            ),
            onChanged: (value) {
              if (value != null) {
                ubahMetodePengambilan(value);
              }
            },
          ),
          const Divider(height: 1),
          RadioListTile<String>(
            value: 'COD',
            groupValue: metodePengambilan,
            activeColor: brown,
            title: const Text(
              'COD - Diantar ke Alamat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            subtitle: const Text(
              'Pesanan diantar dan dibayar saat diterima',
            ),
            secondary: const Icon(
              Icons.delivery_dining,
              color: brown,
            ),
            onChanged: (value) {
              if (value != null) {
                ubahMetodePengambilan(value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildInformasiPenerimaan() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPickup) ...[
            const Text(
              'Tanggal Pengambilan',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: pilihTanggalPengambilan,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: backgroundBrown,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: lightBrown),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: brown,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedPickupDate == null
                            ? 'Pilih tanggal pengambilan'
                            : formatTanggal(selectedPickupDate!),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: brown,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Waktu Pengambilan',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: selectedPickupTime,
              isExpanded: true,
              decoration: InputDecoration(
                hintText: 'Pilih waktu pengambilan',
                prefixIcon: const Icon(
                  Icons.access_time,
                  color: brown,
                ),
                filled: true,
                fillColor: backgroundBrown,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: pickupTimes.map((time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPickupTime = value;
                });
              },
            ),
          ] else ...[
            const Text(
              'Alamat Pengiriman',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Masukkan alamat lengkap',
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: brown,
                ),
                filled: true,
                fillColor: backgroundBrown,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          const Text(
            'Catatan Pesanan (Opsional)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: noteController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'Contoh: tulisan pada kue atau permintaan khusus',
              alignLabelWithHint: true,
              filled: true,
              fillColor: backgroundBrown,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMetodePembayaran() {
    final List<String> paymentOptions = isPickup
        ? ['Bayar di Toko', 'QRIS']
        : ['COD', 'QRIS'];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: paymentOptions.map((method) {
          final bool isQris = method == 'QRIS';

          return RadioListTile<String>(
            value: method,
            groupValue: paymentMethod,
            activeColor: brown,
            title: Text(
              method,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            subtitle: Text(
              isQris
                  ? 'Pembayaran melalui QRIS'
                  : method == 'COD'
                      ? 'Bayar saat pesanan diterima'
                      : 'Bayar ketika mengambil pesanan di toko',
            ),
            secondary: Icon(
              isQris
                  ? Icons.qr_code_2
                  : method == 'COD'
                      ? Icons.delivery_dining
                      : Icons.payments_outlined,
              color: brown,
            ),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                paymentMethod = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Jumlah produk'),
              Text('${getTotalItems()} item'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cara menerima'),
              Flexible(
                child: Text(
                  isPickup ? 'Ambil di Toko' : 'COD',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pembayaran'),
              Text(paymentMethod),
            ],
          ),
          const Divider(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              Text(
                formatRupiah(getTotal()),
                style: const TextStyle(
                  fontSize: 18,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBrown,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: darkBrown,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text('Keranjang masih kosong.'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSectionTitle('Pesanan Kamu'),
                  buildOrderItems(),
                  const SizedBox(height: 22),
                  buildSectionTitle('Cara Menerima Pesanan'),
                  buildMetodePengambilan(),
                  const SizedBox(height: 22),
                  buildSectionTitle(
                    isPickup
                        ? 'Jadwal Pengambilan'
                        : 'Informasi Pengiriman',
                  ),
                  buildInformasiPenerimaan(),
                  const SizedBox(height: 22),
                  buildSectionTitle('Metode Pembayaran'),
                  buildMetodePembayaran(),
                  const SizedBox(height: 22),
                  buildSectionTitle('Ringkasan Pembayaran'),
                  buildPaymentSummary(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isSaving ? null : orderNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brown,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: isSaving
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Buat Pesanan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}