import 'package:flutter/material.dart';

/// Menu ini menjumlahkan DIGIT dari satu angka yang diketik
/// di dalam satu field input, sesuai bunyi soal:
/// "Menu Jumlah total angka dalam suatu field input data"
/// contoh: input "2547" -> 2 + 5 + 4 + 7 = 18
class TotalPage extends StatefulWidget {
  const TotalPage({super.key});

  @override
  State<TotalPage> createState() => _TotalPageState();
}

class _TotalPageState extends State<TotalPage> {
  final TextEditingController _controller = TextEditingController();
  int? _hasilTotal;
  String? _errorText;

  int _jumlahkanDigit(String input) {
    int total = 0;
    for (int i = 0; i < input.length; i++) {
      final digit = int.tryParse(input[i]);
      if (digit != null) {
        total += digit;
      }
    }
    return total;
  }

  void _hitungTotal() {
    final input = _controller.text.trim();
    if (input.isEmpty || int.tryParse(input) == null) {
      setState(() {
        _errorText = 'Masukkan angka yang valid';
        _hasilTotal = null;
      });
      return;
    }
    setState(() {
      _errorText = null;
      _hasilTotal = _jumlahkanDigit(input);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jumlah Total',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Menjumlahkan digit dari angka yang diketik',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const Text(
            'Input Bilangan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'contoh: 2547',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: _errorText,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _hitungTotal,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.pink[300],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Hitung Jumlah'),
            ),
          ),
          const SizedBox(height: 24),
          if (_hasilTotal != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFE1EC), Color(0xFFF1EAFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'TOTAL KESELURUHAN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[400],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$_hasilTotal',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'dari angka ${_controller.text}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}