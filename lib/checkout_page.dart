import 'package:flutter/material.dart';
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
    String priceString = value.toString();
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

    for (int quantity in widget.cart.values) {
      total += quantity;
    }

    return total;
  }

  // =========================================================
  // PESANAN BERHASIL
  // =========================================================

  void orderNow() {
    if (addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan masukkan alamat terlebih dahulu.',
          ),
          backgroundColor: Color(0xFF5D321D),
        ),
      );

      return;
    }

    showDialog(
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
              color: Color(0xFF5D321D),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8D5C4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 40,
                  color: Color(0xFF8B5E3C),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Pesanan kamu telah berhasil dibuat.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                'Total: ${formatRupiah(getTotal())}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5E3C),
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Jumlah produk: ${getTotalItems()}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Stok baru berkurang setelah checkout berhasil
                  widget.onOrderSuccess();

                  // Tutup dialog
                  Navigator.pop(dialogContext);

                  // Kembali dari halaman checkout
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5E3C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Selesai',
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
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8B5E3C),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================
            // DAFTAR PESANAN
            // =================================================

            const Text(
              'Pesanan Kamu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D321D),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: widget.cart.entries.map((entry) {
                  final Kue cake = entry.key;
                  final int quantity = entry.value;

                  final int subtotal =
                      cake.price * quantity;

                  return Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        // FOTO
                        Container(
                          width: 70,
                          height: 70,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8F1),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            cake.image,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // NAMA + HARGA
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                cake.name,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF5D321D),
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
                            color: Color(0xFF8B5E3C),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // ALAMAT
            // =================================================

            const Text(
              'Alamat Pengiriman',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D321D),
              ),
            ),

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
                  hintText:
                      'Masukkan alamat lengkap...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      bottom: 55,
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF8B5E3C),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // METODE PEMBAYARAN
            // =================================================

            const Text(
              'Metode Pembayaran',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D321D),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  // COD
                  RadioListTile<String>(
                    value: 'COD',
                    groupValue: paymentMethod,
                    activeColor:
                        const Color(0xFF8B5E3C),
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                    title: const Text(
                      'COD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D321D),
                      ),
                    ),
                    subtitle: const Text(
                      'Bayar saat pesanan diterima',
                    ),
                    secondary: const Icon(
                      Icons.payments_outlined,
                      color: Color(0xFF8B5E3C),
                    ),
                  ),

                  const Divider(
                    height: 1,
                    indent: 15,
                    endIndent: 15,
                  ),

                  // QRIS
                  RadioListTile<String>(
                    value: 'QRIS',
                    groupValue: paymentMethod,
                    activeColor:
                        const Color(0xFF8B5E3C),
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                    title: const Text(
                      'QRIS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D321D),
                      ),
                    ),
                    subtitle: const Text(
                      'Bayar menggunakan QRIS',
                    ),
                    secondary: const Icon(
                      Icons.qr_code_2,
                      color: Color(0xFF8B5E3C),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // QRIS
            // =================================================

            if (paymentMethod == 'QRIS') ...[
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Scan QRIS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D321D),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Scan kode QR berikut untuk melakukan pembayaran.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // GAMBAR QRIS
                    Container(
                      width: 280,
                      height: 280,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              const Color(0xFFE8D5C4),
                          width: 2,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/QRIS_ZiaBakery.png',
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons
                                      .image_not_supported_outlined,
                                  size: 50,
                                  color:
                                      Color(0xFF8B5E3C),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Gambar QRIS tidak ditemukan',
                                  textAlign:
                                      TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Total pembayaran: ${formatRupiah(getTotal())}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B5E3C),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Setelah melakukan pembayaran, klik tombol Pesan Sekarang.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 25),

            // =================================================
            // RINGKASAN TOTAL
            // =================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jumlah Produk',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${getTotalItems()} item',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D321D),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        paymentMethod,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D321D),
                        ),
                      ),
                    ],
                  ),

                  const Divider(
                    height: 25,
                  ),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D321D),
                        ),
                      ),
                      Text(
                        formatRupiah(getTotal()),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B5E3C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // TOMBOL PESAN
            // =================================================

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: orderNow,
                icon: Icon(
                  paymentMethod == 'QRIS'
                      ? Icons.qr_code_2
                      : Icons.shopping_bag_outlined,
                ),
                label: Text(
                  paymentMethod == 'QRIS'
                      ? 'Pesan Sekarang'
                      : 'Pesan Sekarang',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF8B5E3C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
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