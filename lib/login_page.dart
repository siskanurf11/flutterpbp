import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password harus diisi'),
          backgroundColor: Colors.brown,
        ),
      );
    } else if (!email.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email harus menggunakan @gmail.com'),
          backgroundColor: Colors.brown,
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D321D),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 950,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700) {
                    return Row(
                      children: [
                        Expanded(
                          child: buildWelcomeSection(),
                        ),
                        Expanded(
                          child: buildLoginSection(),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      buildWelcomeSection(),
                      buildLoginSection(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BAGIAN KIRI
  // ============================================================

  Widget buildWelcomeSection() {
    return Container(
      height: 560,
      padding: const EdgeInsets.all(35),
      decoration: const BoxDecoration(
        color: Color(0xFF8B4A2B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // LOGO ZIA BAKERY
          Container(
            width: 230,
            height: 230,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8ED),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Image.asset(
              'assets/images/logo_bakery.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.cake,
                  size: 100,
                  color: Color(0xFF8B4A2B),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Welcome to Zia Bakery',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Temukan berbagai kue favoritmu\n'
            'dan nikmati setiap rasanya.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFFFEBDD),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BAGIAN KANAN
  // ============================================================

  Widget buildLoginSection() {
    return Container(
      height: 560,
      padding: const EdgeInsets.symmetric(
        horizontal: 45,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFBF5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D321D),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              'Silakan masuk untuk melanjutkan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 35),

          // EMAIL
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D321D),
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'contoh@gmail.com',
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF8B4A2B),
              ),
              filled: true,
              fillColor: const Color(0xFFF5E9DC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF8B4A2B),
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // PASSWORD
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D321D),
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: passwordController,
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              hintText: 'Masukkan password',
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF8B4A2B),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: Icon(
                  passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color(0xFF8B4A2B),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF5E9DC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF8B4A2B),
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // TOMBOL LOGIN
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4A2B),
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // TEKS BAWAH
          const Center(
            child: Text(
              'Selamat berbelanja di Zia Bakery ♡',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}