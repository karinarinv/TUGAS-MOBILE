import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _display = '0'; // angka yang sedang diketik / hasil
  String _expression = ''; // teks kecil di atas, misal "12 + 8"
  double? _angkaPertama;
  String? _operator;
  bool _mulaiAngkaBaru = false;

  void _tekanAngka(String angka) {
    setState(() {
      if (_display == '0' || _mulaiAngkaBaru) {
        _display = angka;
        _mulaiAngkaBaru = false;
      } else {
        _display += angka;
      }
    });
  }

  void _tekanOperator(String operator) {
    setState(() {
      _angkaPertama = double.parse(_display);
      _operator = operator;
      _expression = '$_display $operator';
      _mulaiAngkaBaru = true;
    });
  }

  void _tekanSama() {
    if (_angkaPertama == null || _operator == null) return;

    final angkaKedua = double.parse(_display);
    double hasil;

    switch (_operator) {
      case '+':
        hasil = _angkaPertama! + angkaKedua;
        break;
      case '−':
        hasil = _angkaPertama! - angkaKedua;
        break;
      case '×':
        hasil = _angkaPertama! * angkaKedua;
        break;
      case '÷':
        if (angkaKedua == 0) {
          setState(() {
            _display = 'Error';
            _expression = 'Tidak bisa dibagi 0';
          });
          return;
        }
        hasil = _angkaPertama! / angkaKedua;
        break;
      default:
        return;
    }

    setState(() {
      _expression = '$_expression $_display =';
      // buang .0 kalau hasilnya bilangan bulat
      _display = hasil == hasil.roundToDouble()
          ? hasil.toInt().toString()
          : hasil.toString();
      _angkaPertama = null;
      _operator = null;
      _mulaiAngkaBaru = true;
    });
  }

  void _tekanClear() {
    setState(() {
      _display = '0';
      _expression = '';
      _angkaPertama = null;
      _operator = null;
      _mulaiAngkaBaru = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Layar tampilan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink[400]!, Colors.pink[200]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  _display,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Keypad 4x4
          Expanded(child: _buildKeypad()),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    final tombol = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', '×'],
      ['1', '2', '3', '−'],
      ['C', '0', '=', '+'],
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        final baris = index ~/ 4;
        final kolom = index % 4;
        final label = tombol[baris][kolom];
        return _buildTombol(label);
      },
    );
  }

  Widget _buildTombol(String label) {
    final isOperator = ['+', '−', '×', '÷'].contains(label);
    final isEqual = label == '=';
    final isClear = label == 'C';

    Color bgColor = Colors.pink[50]!;
    Color textColor = Colors.black87;

    if (isOperator) {
      bgColor = const Color(0xFFF1EAFF);
      textColor = const Color(0xFF8B5CF6);
    } else if (isEqual) {
      bgColor = const Color(0xFF4CAF7D);
      textColor = Colors.white;
    } else if (isClear) {
      bgColor = const Color(0xFFFFE3E3);
      textColor = const Color(0xFFE0567A);
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          if (isClear) {
            _tekanClear();
          } else if (isEqual) {
            _tekanSama();
          } else if (isOperator) {
            _tekanOperator(label);
          } else {
            _tekanAngka(label);
          }
        },
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}