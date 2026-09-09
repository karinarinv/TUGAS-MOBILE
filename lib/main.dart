import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/kalkulator_page.dart';
import 'screens/cek_bilangan_page.dart';
import 'screens/total_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox Angka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.pink,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF3F7),
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
        title: Text(_titles[_index]),
        centerTitle: true,
      ),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.pink[400],
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Hitung'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cek Bilangan'),
          BottomNavigationBarItem(icon: Icon(Icons.functions), label: 'Total'),
        ],
      ),
    );
  }
}