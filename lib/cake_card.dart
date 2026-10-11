
import 'package:flutter/material.dart';
import 'model/kue.dart';

class CakeCard extends StatelessWidget {
  final Kue cake;
  final bool isSaved;
  final double rating;

  final VoidCallback onSave;
  final VoidCallback onAddToCart;
  final VoidCallback onImageTap;

  const CakeCard({
    super.key,
    required this.cake,
    required this.isSaved,
    required this.rating,
    required this.onSave,
    required this.onAddToCart,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B5E3C);
    const darkBrown = Color(0xFF5D321D);

    return Container(
      width: 210,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO PRODUK
            GestureDetector(
              onTap: onImageTap,
              child: Stack(
                children: [
                  SizedBox(
                    height: 155,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        cake.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFF0E3D5),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 45,
                                color: brown,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // FAVORIT
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      elevation: 2,
                      child: IconButton(
                        tooltip: isSaved
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        onPressed: onSave,
                        icon: Icon(
                          isSaved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: brown,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // NAMA PRODUK
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Text(
                cake.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // RATING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: brown,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // HARGA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                cake.getFormattedPrice(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),
            ),

            const SizedBox(height: 4),

            // STOK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                cake.getStockInfo(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            const Spacer(),

            // TOMBOL TAMBAH KE KERANJANG
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: cake.isAvailable()
                      ? onAddToCart
                      : null,
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 17,
                  ),
                  label: Text(
                    cake.isAvailable() ? 'Tambah' : 'Habis',
                    style: const TextStyle(fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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