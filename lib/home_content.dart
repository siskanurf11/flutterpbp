
import 'package:flutter/material.dart';
import 'model/kue.dart';
import 'data/kue_data.dart';
import 'cake_card.dart';
import 'checkout_page.dart';
import 'rating_widget.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController searchController = TextEditingController();

  // DATA KERANJANG, RATING, DAN FAVORIT
  final Map<Kue, int> cart = {};
  final Map<Kue, double> ratings = {};
  final List<Kue> savedProducts = [];

  // SEARCH
  String searchText = '';

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.toLowerCase();
      });
    });
  }

  // FILTER PRODUK BERDASARKAN SEARCH DAN KATEGORI
  List<Kue> getProductsByCategory(String category) {
    return kueData.where((cake) {
      return cake.category == category &&
          cake.name.toLowerCase().contains(searchText);
    }).toList();
  }

  // RATING
  double getRating(Kue cake) {
    return ratings[cake] ?? 4.5;
  }

  // FAVORIT
  void toggleSaved(Kue cake) {
    setState(() {
      if (savedProducts.contains(cake)) {
        savedProducts.remove(cake);
      } else {
        savedProducts.add(cake);
      }
    });
  }

  // TAMBAH KE KERANJANG
  void addToCart(Kue cake) {
    setState(() {
      int currentQuantity = cart[cake] ?? 0;

      if (currentQuantity < cake.stock) {
        cart[cake] = currentQuantity + 1;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${cake.name} ditambahkan ke keranjang'),
            backgroundColor: const Color(0xFF8B5E3C),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Jumlah melebihi stok yang tersedia'),
            backgroundColor: Color(0xFF5D321D),
          ),
        );
      }
    });
  }

  // KURANGI JUMLAH KERANJANG
  void decreaseQuantity(Kue cake) {
    setState(() {
      if (cart.containsKey(cake)) {
        if (cart[cake]! > 1) {
          cart[cake] = cart[cake]! - 1;
        } else {
          cart.remove(cake);
        }
      }
    });
  }

  // JUMLAH ITEM DI KERANJANG
  int getCartItemCount() {
    int total = 0;

    for (int quantity in cart.values) {
      total += quantity;
    }

    return total;
  }

  // TOTAL HARGA KERANJANG
  int getCartTotal() {
    int total = 0;

    cart.forEach((cake, quantity) {
      total += cake.price * quantity;
    });

    return total;
  }

  // FORMAT RUPIAH
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

  // CHECKOUT BERHASIL
  void processSuccessfulCheckout() {
    setState(() {
      cart.forEach((cake, quantity) {
        cake.stock = cake.stock - quantity;
      });

      cart.clear();
    });
  }

  // DETAIL PRODUK
  void showCakeDetail(Kue cake) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        final screenSize = MediaQuery.of(dialogContext).size;

        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 620,
              maxHeight: screenSize.height * 0.88,
            ),
            child: SizedBox(
              width: screenSize.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // FOTO PRODUK
                          Center(
                            child: Container(
                              height: screenSize.width < 500 ? 170 : 210,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8F1),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                cake.image,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 48,
                                      color: Color(0xFF8B5E3C),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // NAMA PRODUK
                          Text(
                            cake.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D321D),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // DESKRIPSI
                          Text(
                            cake.description,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // HARGA
                          Text(
                            cake.getFormattedPrice(),
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B5E3C),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // STOK
                          Text(
                            cake.getStockInfo(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // RATING
                          const Text(
                            'Rating produk',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D321D),
                            ),
                          ),
                          const SizedBox(height: 6),
                          RatingWidget(
                            initialRating: getRating(cake),
                            onRatingChanged: (value) {
                              setState(() {
                                ratings[cake] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // TOMBOL DETAIL
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF8B5E3C),
                              minimumSize: const Size(0, 46),
                              side: const BorderSide(
                                color: Color(0xFF8B5E3C),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text('Tutup'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: cake.isAvailable()
                                ? () {
                                    Navigator.pop(dialogContext);
                                    addToCart(cake);
                                  }
                                : null,
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 18,
                            ),
                            label: Text(
                              cake.isAvailable() ? 'Tambah' : 'Habis',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B5E3C),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                                  Colors.grey.shade300,
                              disabledForegroundColor: Colors.white,
                              minimumSize: const Size(0, 46),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // SECTION KATEGORI PRODUK
  Widget buildCategorySection(String title, List<Kue> products) {
    if (products.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D321D),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 365,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 18),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final cake = products[index];

              return CakeCard(
                cake: cake,
                isSaved: savedProducts.contains(cake),
                rating: getRating(cake),
                onSave: () {
                  toggleSaved(cake);
                },
                onAddToCart: () {
                  addToCart(cake);
                },
                onImageTap: () {
                  showCakeDetail(cake);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // KATEGORI DEKORASI
  Widget buildCategories() {
    final categories = [
      {'icon': Icons.cake, 'name': 'Kue Tradisional'},
      {'icon': Icons.celebration, 'name': 'Kue Ulang Tahun'},
      {'icon': Icons.bakery_dining, 'name': 'Pastry'},
      {'icon': Icons.bakery_dining_outlined, 'name': 'Brownies'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8D5C4),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    categories[index]['icon'] as IconData,
                    color: const Color(0xFF8B5E3C),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  categories[index]['name'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D321D),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // KERANJANG
  void showCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Keranjang Saya',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D321D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: cart.isEmpty
                        ? const Center(
                            child: Text(
                              'Keranjang masih kosong',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final cake = cart.keys.elementAt(index);
                              final quantity = cart[cake]!;

                              return ListTile(
                                leading: SizedBox(
                                  width: 55,
                                  height: 55,
                                  child: Image.asset(
                                    cake.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                title: Text(
                                  cake.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5D321D),
                                  ),
                                ),
                                subtitle: Text(
                                  '${cake.getFormattedPrice()} x $quantity',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        decreaseQuantity(cake);
                                        setModalState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Color(0xFF8B5E3C),
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        addToCart(cake);
                                        setModalState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Color(0xFF8B5E3C),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D321D),
                              ),
                            ),
                            Text(
                              formatRupiah(getCartTotal()),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B5E3C),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: cart.isEmpty
                                ? null
                                : () {
                                    Navigator.pop(context);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckoutPage(
                                          cart: Map<Kue, int>.from(cart),
                                          onOrderSuccess:
                                              processSuccessfulCheckout,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B5E3C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Checkout',
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
                ],
              ),
            );
          },
        );
      },
    );
  }

  // PRODUK TERSIMPAN
  void showSavedProducts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SizedBox(
          height: 450,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Kue Tersimpan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D321D),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: savedProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada kue yang disimpan',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: savedProducts.length,
                        itemBuilder: (context, index) {
                          final cake = savedProducts[index];

                          return ListTile(
                            leading: SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.asset(
                                cake.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(
                              cake.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D321D),
                              ),
                            ),
                            subtitle: Text(cake.getFormattedPrice()),
                            trailing: IconButton(
                              onPressed: () {
                                toggleSaved(cake);
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Color(0xFF8B5E3C),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  // HALAMAN BERANDA
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
            decoration: const BoxDecoration(
              color: Color(0xFF8B5E3C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Zia Bakery 🍰',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Temukan kue favoritmu',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: showSavedProducts,
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: showCart,
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                        if (getCartItemCount() > 0)
                          Positioned(
                            right: 5,
                            top: 3,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xFF5D321D),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${getCartItemCount()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Cari kue yang kamu suka...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF8B5E3C),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // KATEGORI
          buildCategories(),

          const SizedBox(height: 10),

          // DAFTAR PRODUK
          buildCategorySection(
            'Kue Tradisional',
            getProductsByCategory('Kue Tradisional'),
          ),
          buildCategorySection(
            'Kue Ulang Tahun',
            getProductsByCategory('Kue Ulang Tahun'),
          ),
          buildCategorySection(
            'Pastry',
            getProductsByCategory('Pastry'),
          ),
          buildCategorySection(
            'Brownies',
            getProductsByCategory('Brownies'),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // DISPOSE
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}