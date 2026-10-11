import '../model/kue.dart';

final List<Kue> kueData = [
  // =========================
  // KUE TRADISIONAL
  // =========================

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

  // =========================
  // KUE ULANG TAHUN
  // =========================

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

  // =========================
  // PASTRY
  // =========================

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