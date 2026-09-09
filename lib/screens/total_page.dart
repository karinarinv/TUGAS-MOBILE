// total_page.dart
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
          Text(
            'Jumlah Total',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[900],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Tambahkan angka satu per satu atau dari kalimat',
            style: TextStyle(fontSize: 13, color: Colors.deepPurple[300]),
          ),
          const SizedBox(height: 20),

          Text(
            'Input Bilangan',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.deepPurple[700],
            ),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: _controller,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'contoh: 12 atau Saya beli 2 apel dan 5 jeruk',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.deepPurple.shade200,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.deepPurple.shade100),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.deepPurple.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.deepPurple[300]!, width: 1.5),
              ),
              errorText: _errorText,
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _hitungTotal,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.deepPurple[300],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Jumlahkan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 24),

          if (_hasilTotal != null) ...[
            Text(
              'Angka yang Sudah Dimasukkan',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple[400],
              ),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _extractedNumbers.map((numVal) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$numVal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[700],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple[50]!,
                    const Color(0xFFF3E5F5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'TOTAL KESELURUHAN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple[400],
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_hasilTotal',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[900],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'dari ${_extractedNumbers.length} angka yang dimasukkan',
                    style: TextStyle(fontSize: 12, color: Colors.deepPurple[300]),
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