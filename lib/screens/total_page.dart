import 'package:flutter/material.dart';

class TotalPage extends StatefulWidget {
  const TotalPage({super.key});

  @override
  State<TotalPage> createState() => _TotalPageState();
}

class _TotalPageState extends State<TotalPage> {
  final TextEditingController _controller = TextEditingController();
  List<int> _extractedNumbers = [];
  int? _hasilTotal;
  String? _errorText;

  void _hitungTotal() {
    final input = _controller.text.trim();

    if (input.isEmpty) {
      setState(() {
        _errorText = 'Masukkan teks atau angka terlebih dahulu';
        _hasilTotal = null;
        _extractedNumbers = [];
      });
      return;
    }

    // Mengambil semua digit angka (0-9) dari teks input
    RegExp regExp = RegExp(r'\d');
    Iterable<Match> matches = regExp.allMatches(input);

    List<int> numbers = matches.map((m) => int.parse(m.group(0)!)).toList();

    if (numbers.isEmpty) {
      setState(() {
        _errorText = 'Tidak ada angka yang ditemukan dalam input';
        _hasilTotal = null;
        _extractedNumbers = [];
      });
      return;
    }

    int total = numbers.reduce((a, b) => a + b);

    setState(() {
      _errorText = null;
      _extractedNumbers = numbers;
      _hasilTotal = total;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Judul
          Row(
            children: const [
              Text(
                'Jumlah Total',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 6),
              Text('✨', style: TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'tambahkan angka satu per satu atau dari kalimat',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // Label Input
          const Text(
            'input bilangan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFFC2185B),
            ),
          ),
          const SizedBox(height: 8),

          // TextField Input
          TextField(
            controller: _controller,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'contoh: 12 atau Saya beli 2 apel dan 5 jeruk',
              hintStyle: TextStyle(color: Colors.pink.shade200, fontSize: 13),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.pink.shade100),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.pink.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE91E63), width: 1.5),
              ),
              errorText: _errorText,
            ),
          ),
          const SizedBox(height: 16),

          // Tombol Jumlahkan
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _hitungTotal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC407A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Jumlahkan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Tampilan Hasil (Chip Angka & Card Total)
          if (_hasilTotal != null) ...[
            const Text(
              'angka yang sudah dimasukkan',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Daftar Chip Angka
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _extractedNumbers.map((numVal) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE4EC), // Soft pink
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$numVal',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC2185B),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Card Result Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFF0F5),
                    Color(0xFFF3E5F5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'TOTAL KESELURUHAN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD81B60),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_hasilTotal',
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'dari ${_extractedNumbers.length} angka yang dimasukkan',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}