import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/kalkulator_page.dart';
import 'screens/cek_bilangan_page.dart';
import 'screens/total_page.dart';

void main() {
  runApp(const MyApp());
}

// Warna utama aplikasi, dipakai bersama di semua halaman
class AppColors {
  static const Color blue = Color(0xFF3B6FE0);
  static const Color blueLight = Color(0xFFEAF1FF);
  static const Color pink = Color(0xFFE0568A);
  static const Color pinkLight = Color(0xFFFCE8F0);
  static const Color background = Color(0xFFFAFAFC);
  static const Color textPrimary = Color(0xFF262832);
  static const Color textSecondary = Color(0xFF8A8D98);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox Angka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 194, 212, 249),
          primary: const Color.fromARGB(255, 165, 194, 255),
          secondary: AppColors.pink,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      // Aplikasi dibuka dari halaman login dulu
      home: const LoginPage(),
    );
  }
}

/// Halaman ini yang menampung 4 tab (Beranda, Hitung, Cek Bilangan, Total)
/// Dipanggil dari LoginPage setelah login berhasil.
class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;

  // IndexedStack dipakai supaya state tiap tab tidak reset saat pindah tab
  final List<Widget> _pages = const [
    HomePage(),
    KalkulatorPage(),
    CekBilanganPage(),
    TotalPage(),
  ];

  final List<String> _titles = const [
    'Beranda',
    'Hitung',
    'Cek Bilangan',
    'Total',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_index],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: AppColors.pink,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate_outlined), label: 'Hitung'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Cek Bilangan'),
          BottomNavigationBarItem(icon: Icon(Icons.functions_outlined), label: 'Total'),
        ],
      ),
    );
  }
}