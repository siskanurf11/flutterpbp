import 'package:flutter/material.dart';
import 'home_content.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // Warna cokelat
  final Color darkBrown = const Color(0xFF5D321D);
  final Color brown = const Color(0xFF8B5E3C);
  final Color lightBrown = const Color(0xFFE8D5C4);
  final Color backgroundBrown = const Color(0xFFFFF8F1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBrown,

      // ================= APP BAR =================

      appBar: AppBar(
        title: Text(
          selectedIndex == 0 ? 'Home' : 'Profile',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: brown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ================= ISI =================

      body: selectedIndex == 0
          ? const HomeContent()
          : const ProfilePage(),

      // ================= NAVBAR =================

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // =========================================================
  // NAVBAR
  // =========================================================

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: brown.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: 'Home',
            index: 0,
          ),

          _buildNavItem(
            icon: Icons.person,
            label: 'Profile',
            index: 1,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ITEM NAVBAR
  // =========================================================

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 58 : 45,
            height: isSelected ? 58 : 45,
            decoration: BoxDecoration(
              color: isSelected
                  ? brown
                  : lightBrown,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: isSelected ? 30 : 25,
              color: isSelected
                  ? Colors.white
                  : brown,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: isSelected
                  ? brown
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}