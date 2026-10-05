import 'package:flutter/material.dart';
import 'model/kue.dart';
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

  // =========================================================
  // DATA KUE
  // =========================================================

  final List<Kue> cakeData = [
    // =======================================================
    // KUE TRADISIONAL
    // =======================================================

    Kue(
      image: 'assets/images/tradisi_cake1.jpg',
      name: 'Clorot',
      description:
          'Kue dari tepung beras, santan, dan gula merah yang dibungkus janur, bertekstur lembut dan manis.',
      price: 6000,
      stock: 15,
      category: 'Kue Tradisional',
    ),

    Kue(
      image: 'assets/images/tradisi_cake2.jpg',
      name: 'Nagasari',
      description:
          'Kue tepung beras berisi pisang yang dibungkus daun pisang dan dikukus.',
      price: 3000,
      stock: 15,
      category: 'Kue Tradisional',
    ),

    Kue(
      image: 'assets/images/tradisi_cake3.jpg',
      name: 'Kue Bugis',
      description:
          'Kue ketan berisi kelapa manis, bertekstur kenyal dan bercita rasa manis.',
      price: 4000,
      stock: 12,
      category: 'Kue Tradisional',
    ),

    Kue(
      image: 'assets/images/tradisi_cake4.jpg',
      name: 'Kue Talam',
      description:
          'Kue berlapis berbahan tepung dan santan dengan rasa manis gurih.',
      price: 4000,
      stock: 10,
      category: 'Kue Tradisional',
    ),

    Kue(
      image: 'assets/images/tradisi_cake5.jpg',
      name: 'Lemper',
      description:
          'Ketan berisi ayam atau abon yang dibungkus daun pisang, bercita rasa gurih.',
      price: 4000,
      stock: 10,
      category: 'Kue Tradisional',
    ),

    Kue(
      image: 'assets/images/tradisi_cake6.jpg',
      name: 'Dadar Gulung Pandan',
      description:
          'Kue tradisional berbahan kulit pandan yang lembut dan beraroma khas, berisi kelapa parut manis yang dimasak dengan gula merah.',
      price: 4000,
      stock: 10,
      category: 'Kue Tradisional',
    ),

    Kue(
      image: 'assets/images/tradisi_cake7.jpg',
      name: 'Putu Ayu Gulung',
      description:
          'Kue tradisional berbahan pandan yang lembut dengan isian gula merah manis dan balutan kelapa parut gurih.',
      price: 4000,
      stock: 10,
      category: 'Kue Tradisional',
    ),

    // =======================================================
    // KUE ULANG TAHUN
    // =======================================================

    Kue(
      image: 'assets/images/ultah_cake1.jpg',
      name: 'Pretzel Cream Cake',
      description:
          'Kue ulang tahun dengan dekorasi krim lembut dan topping pretzel yang unik, menghadirkan perpaduan tampilan minimalis serta cita rasa manis yang istimewa.',
      price: 90000,
      stock: 5,
      category: 'Kue Ulang Tahun',
    ),

    Kue(
      image: 'assets/images/ultah_cake2.jpg',
      name: 'Choco Drip Cake',
      description:
          'Kue cokelat premium dengan lapisan ganache drip yang lembut, dihias cokelat dan krim manis untuk menciptakan tampilan elegan dan cita rasa yang kaya.',
      price: 120000,
      stock: 5,
      category: 'Kue Ulang Tahun',
    ),

    Kue(
      image: 'assets/images/ultah_cake3.jpg',
      name: 'Pink Blossom Cake',
      description:
          'Kue ulang tahun dengan dekorasi pink yang cantik dan estetik, cocok untuk berbagai perayaan spesial.',
      price: 90000,
      stock: 5,
      category: 'Kue Ulang Tahun',
    ),

    Kue(
      image: 'assets/images/ultah_cake4.jpg',
      name: 'Korean Bento Cake',
      description:
          'Kue mini estetik bergaya Korea dengan dekorasi simpel dan warna pastel yang cantik, cocok untuk berbagai acara spesial.',
      price: 55000,
      stock: 10,
      category: 'Kue Ulang Tahun',
    ),

    Kue(
      image: 'assets/images/ultah_cake5.jpg',
      name: 'Lotso Cake',
      description:
          'Kue bertema beruang Lotso dengan dekorasi warna pink yang lucu dan menarik, cocok untuk ulang tahun atau acara spesial.',
      price: 150000,
      stock: 4,
      category: 'Kue Ulang Tahun',
    ),

    Kue(
      image: 'assets/images/ultah_cake6.jpg',
      name: 'Rainbow Fruit Cake',
      description: 
         'Kue ulang tahun berwarna-warni dengan lapisan krim pelangi dan topping buah segar seperti stroberi, kiwi, anggur, jeruk, dan nanas.',
      price: 150000,
      stock: 5,
      category: 'Kue Ulang Tahun',
    ),

    Kue(
      image: 'assets/images/ultah_cake7.jpg',
      name: 'Pastel Dream Cake',
      description: 
         'Kue ulang tahun dengan kombinasi warna pastel biru dan pink yang lembut, dihiasi tulisan ucapan sederhana untuk menciptakan tampilan manis, elegan, dan estetik.',
      price: 80000,
      stock: 5,
      category: 'Kue Ulang Tahun',
    ),

    // =======================================================
    // PASTRY
    // =======================================================

    Kue(
      image: 'assets/images/pastry_cake1.jpg',
      name: 'Berry Puff Pastry',
      description:
          'Pastry renyah berlapis dengan isian krim lembut dan topping buah beri segar, menghadirkan perpaduan rasa manis, segar, dan lezat dalam setiap gigitan.',
      price: 30000,
      stock: 12,
      category: 'Pastry',
    ),

    Kue(
      image: 'assets/images/pastry_cake2.jpg',
      name: 'Choco Roll Pastry',
      description:
          'Pastry gulung renyah dengan isian cokelat yang lumer dan taburan gula halus, menghadirkan rasa manis yang lezat di setiap gigitan.',
      price: 15000,
      stock: 10,
      category: 'Pastry',
    ),

    Kue(
      image: 'assets/images/pastry_cake3.jpg',
      name: 'Cherry Danish Pastry',
      description:
          'Pastry berlapis yang renyah dengan topping ceri manis dan lapisan glasir lembut, menghadirkan perpaduan rasa manis dan segar yang menggugah selera.',
      price: 25000,
      stock: 10,
      category: 'Pastry',
    ),

    Kue(
      image: 'assets/images/pastry_cake4.jpg',
      name: 'Blueberry Cream Puff',
      description:
          'Pastry renyah berlapis dengan isian blueberry manis dan topping meringue lembut, menciptakan perpaduan rasa manis, segar, dan elegan.',
      price: 18000,
      stock: 8,
      category: 'Pastry',
    ),

    Kue(
      image: 'assets/images/pastry_cake5.jpg',
      name: 'Berry Bliss Pastry',
      description:
          'Pastry berlapis yang renyah dengan isian stroberi manis dan segar, dipadukan dengan taburan gula halus yang menambah cita rasa lezat dan tampilan menggoda.',
      price: 20000,
      stock: 8,
      category: 'Pastry',
    ),

    Kue(
      image: 'assets/images/pastry_cake6.webp',
      name: 'Strawberry Croissant',
      description:
          'Pastry croissant renyah dengan sentuhan stroberi segar yang manis dan menyegarkan.',
      price: 25000,
      stock: 8,
      category: 'Pastry',
    ),

    Kue(
      image: 'assets/images/pastry_cake7.jpg',
      name: 'Shortcrust Pastry',
      description:
          'Pastry dengan tekstur renyah dan rapuh yang dibuat dari campuran tepung, mentega, dan gula. Cocok digunakan sebagai dasar berbagai pie dan tart.',
      price: 50000,
      stock: 8,
      category: 'Pastry',
    ),

  ];

  // =========================================================
  // KERANJANG, RATING, DAN FAVORIT
  // =========================================================

  final Map<Kue, int> cart = {};

  final Map<Kue, double> ratings = {};

  final List<Kue> savedProducts = [];

  // =========================================================
  // SEARCH
  // =========================================================

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

  // =========================================================
  // FILTER PRODUK BERDASARKAN SEARCH + KATEGORI
  // =========================================================

  List<Kue> getProductsByCategory(String category) {
    return cakeData.where((cake) {
      return cake.category == category &&
          cake.name.toLowerCase().contains(searchText);
    }).toList();
  }

  // =========================================================
  // RATING
  // =========================================================

  double getRating(Kue cake) {
    return ratings[cake] ?? 4.5;
  }

  // =========================================================
  // FAVORIT
  // =========================================================

  void toggleSaved(Kue cake) {
    setState(() {
      if (savedProducts.contains(cake)) {
        savedProducts.remove(cake);
      } else {
        savedProducts.add(cake);
      }
    });
  }

  // =========================================================
  // TAMBAH KE KERANJANG
  // =========================================================

  void addToCart(Kue cake) {
    setState(() {
      int currentQuantity = cart[cake] ?? 0;

      if (currentQuantity < cake.stock) {
        cart[cake] = currentQuantity + 1;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${cake.name} ditambahkan ke keranjang',
            ),
            backgroundColor: const Color(0xFF8B5E3C),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Jumlah melebihi stok yang tersedia',
            ),
            backgroundColor: Color(0xFF5D321D),
          ),
        );
      }
    });
  }

  // =========================================================
  // KURANGI JUMLAH KERANJANG
  // =========================================================

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

  // =========================================================
  // JUMLAH ITEM DI KERANJANG
  // =========================================================

  int getCartItemCount() {
    int total = 0;

    for (int quantity in cart.values) {
      total += quantity;
    }

    return total;
  }

  // =========================================================
  // TOTAL HARGA KERANJANG
  // =========================================================

  int getCartTotal() {
    int total = 0;

    cart.forEach((cake, quantity) {
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
  // CHECKOUT BERHASIL
  // =========================================================

  void processSuccessfulCheckout() {
    setState(() {
      cart.forEach((cake, quantity) {
        cake.stock = cake.stock - quantity;
      });

      cart.clear();
    });
  }

  // =========================================================
  // DETAIL PRODUK
  // =========================================================

  void showCakeDetail(Kue cake) {
    double currentRating = getRating(cake);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        cake.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  cake.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D321D),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  cake.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  cake.getFormattedPrice(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B5E3C),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  cake.getStockInfo(),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Rating',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D321D),
                  ),
                ),

                const SizedBox(height: 5),

                RatingWidget(
                  initialRating: currentRating,
                  onRatingChanged: (value) {
                    setState(() {
                      ratings[cake] = value;
                    });
                  },
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color(0xFF8B5E3C),
                        ),
                        child: const Text('Tutup'),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: cake.isAvailable()
                            ? () {
                                Navigator.pop(context);
                                addToCart(cake);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF8B5E3C),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Tambah'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // SECTION KATEGORI
  // =========================================================

  Widget buildCategorySection(
    String title,
    List<Kue> products,
  ) {
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

        // BAGIAN PRODUK BISA DIGESER KE SAMPING
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

  // =========================================================
  // KATEGORI DEKORASI
  // =========================================================

  Widget buildCategories() {
    final categories = [
      {
        'icon': Icons.grid_view_rounded,
        'name': 'Semua',
      },
      {
        'icon': Icons.cake,
        'name': 'Kue Tradisional',
      },
      {
        'icon': Icons.celebration,
        'name': 'Kue Ulang Tahun',
      },
      {
        'icon': Icons.bakery_dining,
        'name': 'Pastry',
      },
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

  // =========================================================
  // KERANJANG
  // =========================================================

  void showCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
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
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final cake =
                                  cart.keys.elementAt(index);

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

                  // TOTAL
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
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                                        builder: (context) =>
                                            CheckoutPage(
                                          cart:
                                              Map<Kue, int>.from(cart),
                                          onOrderSuccess:
                                              processSuccessfulCheckout,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8B5E3C),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
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

  // =========================================================
  // PRODUK TERSIMPAN
  // =========================================================

  void showSavedProducts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
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
                          style: TextStyle(
                            color: Colors.grey,
                          ),
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

                            subtitle: Text(
                              cake.getFormattedPrice(),
                            ),

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

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ===================================================
          // HEADER
          // ===================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              18,
              20,
              18,
              18,
            ),
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
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

                    // FAVORIT
                    IconButton(
                      onPressed: showSavedProducts,
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),

                    // KERANJANG
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
                              padding:
                                  const EdgeInsets.all(5),
                              decoration:
                                  const BoxDecoration(
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

                // SEARCH
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration:
                        const InputDecoration(
                      hintText:
                          'Cari kue yang kamu suka...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF8B5E3C),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ===================================================
          // KATEGORI
          // ===================================================

          buildCategories(),

          const SizedBox(height: 10),

          // ===================================================
          // KUE TRADISIONAL
          // ===================================================

          buildCategorySection(
            'Kue Tradisional',
            getProductsByCategory(
              'Kue Tradisional',
            ),
          ),

          // ===================================================
          // KUE ULANG TAHUN
          // ===================================================

          buildCategorySection(
            'Kue Ulang Tahun',
            getProductsByCategory(
              'Kue Ulang Tahun',
            ),
          ),

          // ===================================================
          // PASTRY
          // ===================================================

          buildCategorySection(
            'Pastry',
            getProductsByCategory(
              'Pastry',
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}