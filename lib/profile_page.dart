import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ================= WARNA =================

  static const Color brown = Color(0xFF8B5E3C);
  static const Color darkBrown = Color(0xFF5D321D);
  static const Color lightBrown = Color(0xFFE8D5C4);
  static const Color cream = Color(0xFFFFF8F1);

  // ================= DATA PROFILE =================

  String nama = 'Siska';
  String birthday = 'Birthday';
  String phone = '0812 3456 7890';
  String instagram = 'Instagram account';
  String email = 'siska@gmail.com';
  String password = 'Password';

  // ================= CONTROLLER =================

  final TextEditingController namaController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController instagramController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    instagramController.dispose();
    emailController.dispose();

    super.dispose();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),

            const SizedBox(height: 75),

            _buildAboutMe(),

            const SizedBox(height: 25),

            _buildPersonalInformation(),

            const SizedBox(height: 25),

            _buildInstagram(),

            const SizedBox(height: 25),

            _buildEducation(),

            const SizedBox(height: 25),

            _buildAccount(),

            const SizedBox(height: 30),

            _buildEditButton(),

            const SizedBox(height: 15),

            _buildLogoutButton(),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 270,
          decoration: const BoxDecoration(
            color: brown,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(55),
              bottomRight: Radius.circular(55),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 35,
              left: 25,
              right: 25,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  'Welcome to Zia Bakery',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),

        // FOTO PROFILE
        Positioned(
          bottom: -58,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 125,
              height: 125,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpeg',
                  width: 115,
                  height: 115,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      size: 70,
                      color: brown,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // ABOUT ME
  // =========================================================

  Widget _buildAboutMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: brown.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: lightBrown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: brown,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Text(
              'Halo! Saya adalah mahasiswa Teknik Informatika '
              'Universitas Negeri Surabaya yang memiliki ketertarikan '
              'pada teknologi dan pengembangan aplikasi.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // INFORMASI PRIBADI
  // =========================================================

  Widget _buildPersonalInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _smallInfoCard(
                  icon: Icons.cake_outlined,
                  title: 'Birthday',
                  value: birthday,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _smallInfoCard(
                  icon: Icons.phone_android,
                  title: 'Phone',
                  value: phone,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: lightBrown,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: lightBrown,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: brown,
              size: 21,
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // INSTAGRAM
  // =========================================================

  Widget _buildInstagram() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: lightBrown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: brown,
                size: 26,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instagram',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    instagram,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: brown,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // EDUCATION
  // =========================================================

  Widget _buildEducation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: brown.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: lightBrown,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.school_outlined,
                color: brown,
                size: 27,
              ),
            ),

            const SizedBox(width: 15),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'S1 Teknik Informatika',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Universitas Negeri Surabaya',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // ACCOUNT
  // =========================================================

  Widget _buildAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: lightBrown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    color: brown,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: lightBrown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: brown,
                  ),
                ),

                const SizedBox(width: 14),

                const Expanded(
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // EDIT PROFILE BUTTON
  // =========================================================

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: _showEditProfile,
          icon: const Icon(Icons.edit_outlined),
          label: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: brown,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // LOGOUT BUTTON
  // =========================================================

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: _showLogoutDialog,
          icon: const Icon(Icons.logout_outlined),
          label: const Text(
            'Log Out',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: brown,
            side: const BorderSide(
              color: brown,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EDIT PROFILE
  // =========================================================

  void _showEditProfile() {
    namaController.text = nama;
    birthdayController.text = birthday;
    phoneController.text = phone;
    instagramController.text = instagram;
    emailController.text = email;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _editField(
                  controller: namaController,
                  label: 'Nama',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 12),

                _editField(
                  controller: birthdayController,
                  label: 'Birthday',
                  icon: Icons.cake_outlined,
                ),

                const SizedBox(height: 12),

                _editField(
                  controller: phoneController,
                  label: 'Nomor HP',
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 12),

                _editField(
                  controller: instagramController,
                  label: 'Instagram',
                  icon: Icons.camera_alt_outlined,
                ),

                const SizedBox(height: 12),

                _editField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  nama = namaController.text;
                  birthday = birthdayController.text;
                  phone = phoneController.text;
                  instagram = instagramController.text;
                  email = emailController.text;
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile berhasil diperbarui!',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: brown,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _editField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: brown,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: brown,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  // =========================================================
  // LOG OUT
  // =========================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: brown,
                foregroundColor: Colors.white,
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}