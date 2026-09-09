import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _display = '0';
  String _expression = ''; // teks kecil di atas, misal "12 + 8"
  double? _angkaPertama;
  String? _operator;
  bool _mulaiAngkaBaru = false; //input operasi angka kedua merupakan angka baru
  bool _isError = false;

  String _formatRaw(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == 0) return '0';

    final bool negatif = value.isNegative;
    final double absVal = value.abs();

    final String expStr = absVal.toStringAsExponential(15);
    final int eIndex = expStr.indexOf('e');
    final String digit = expStr.substring(0, eIndex).replaceAll('.', '');
    final int exponent = int.parse(expStr.substring(eIndex + 1));

    // posisi titik desimal dihitung dari digit paling kiri
    final int titikDesimal = 1 + exponent;

    String s;
    if (titikDesimal <= 0) {
      s = '0.${'0' * (-titikDesimal)}$digit';
    } else if (titikDesimal >= digit.length) {
      s = digit + ('0' * (titikDesimal - digit.length));
    } else {
      s = '${digit.substring(0, titikDesimal)}.${digit.substring(titikDesimal)}';
    }

    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
      s = s.replaceAll(RegExp(r'\.$'), '');
    }

    s = s.replaceAll('.', ','); // koma sebagai pemisah desimal
    return negatif ? '-$s' : s;
  }

  /// Menambahkan titik pemisah ribuan khusus untuk TAMPILAN,
  /// tanpa mengubah _display "mentah" yang dipakai untuk perhitungan.
  /// Contoh: "1000000000000" -> "1.000.000.000.000"
  String _formatTampilan(String raw) {
    if (raw.isEmpty) return '0';
    if (raw == 'Error') return raw;

    final bool negatif = raw.startsWith('-');
    final String tanpaTanda = negatif ? raw.substring(1) : raw;

    final List<String> bagian = tanpaTanda.split(',');
    final String bagianBulat = bagian[0];
    final String? bagianDesimal = bagian.length > 1 ? bagian[1] : null;

    final String dibalik = bagianBulat.split('').reversed.join();
    final List<String> potongan = [];
    for (int i = 0; i < dibalik.length; i += 3) {
      final int akhir = (i + 3 > dibalik.length) ? dibalik.length : i + 3;
      potongan.add(dibalik.substring(i, akhir));
    }
    final String hasilBulat = potongan.join('.').split('').reversed.join();

    String hasilAkhir = hasilBulat.isEmpty ? '0' : hasilBulat;
    if (bagianDesimal != null) {
      hasilAkhir += ',$bagianDesimal';
    }
    if (negatif) hasilAkhir = '-$hasilAkhir';

    return hasilAkhir;
  }

  // ==========================================================
  // AKSI TOMBOL
  // ==========================================================

  void _tekanAngka(String angka) {
    setState(() {
      _isError = false;
      if (_display == '0' || _mulaiAngkaBaru) {
        _display = angka;
        _mulaiAngkaBaru = false;
      } else {
        _display += angka;
      }
    });
  }

  void _tekanKoma() {
    setState(() {
      _isError = false;
      if (_mulaiAngkaBaru) {
        _display = '0,';
        _mulaiAngkaBaru = false;
      } else if (_display.isEmpty || _display == '-') {
        _display += '0,';
      } else if (!_display.contains(',')) {
        _display += ',';
      }
    });
  }

  void _tekanPlusMinus() {
    setState(() {
      _isError = false;
      if (_display == '0' || _mulaiAngkaBaru) {
        _display = '-';
        _mulaiAngkaBaru = false;
      } else if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else {
        _display = '-$_display';
      }
    });
  }

  void _hapusSatuDigit() {
    if (_mulaiAngkaBaru) return; // tidak ada yang bisa dihapus di kondisi ini
    setState(() {
      _isError = false;
      if (_display.length <= 1 || _display == '-') {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  void _tekanOperator(String operator) {
    // Validasi: pastikan angka yang sedang tampil benar-benar bisa
    // diubah jadi angka sebelum operator disimpan.
    final double? angka = double.tryParse(_display.replaceAll(',', '.'));
    if (angka == null) {
      _tampilkanError('Masukkan angka yang benar');
      return;
    }

    setState(() {
      _isError = false;
      _angkaPertama = angka;
      _operator = operator;
      _expression = '${_formatTampilan(_display)} $operator';
      _mulaiAngkaBaru = true;
    });
  }

  void _tampilkanError(String pesan) {
    setState(() {
      _isError = true;
      _display = pesan;
      _expression = '';
      _angkaPertama = null;
      _operator = null;
      _mulaiAngkaBaru = false;
    });
  }

  void _tekanSama() {
    if (_angkaPertama == null || _operator == null) return;

    final double? angkaKedua = double.tryParse(_display.replaceAll(',', '.'));
    if (angkaKedua == null) {
      _tampilkanError('Masukkan angka yang benar');
      return;
    }

    double hasil;
    switch (_operator) {
      case '+':
        hasil = _angkaPertama! + angkaKedua;
        break;
      case '-':
        hasil = _angkaPertama! - angkaKedua;
        break;
      case '×':
        hasil = _angkaPertama! * angkaKedua;
        break;
      case '÷':
        if (angkaKedua == 0) {
          _tampilkanError('Tidak bisa dibagi 0');
          return;
        }
        hasil = _angkaPertama! / angkaKedua;
        break;
      default:
        return;
    }

    setState(() {
      _isError = false;
      _expression = '$_expression ${_formatTampilan(_display)} =';
      _display = _formatRaw(hasil); // simpan mentah, siap dipakai hitung lanjut
      _angkaPertama = null;
      _operator = null;
      _mulaiAngkaBaru = true;
    });
  }

  void _tekanClear() {
    setState(() {
      _isError = false;
      _display = '0';
      _expression = '';
      _angkaPertama = null;
      _operator = null;
      _mulaiAngkaBaru = false;
    });
  }

  // ==========================================================
  // UI
  // ==========================================================

  Widget _tombolKalkulator(
    String teks, {
    bool isOperator = false,
    bool isHasil = false,
    bool isFungsi = false,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {
            if (teks == 'C') {
              _tekanClear();
            } else if (teks == '=') {
              _tekanSama();
            } else if (teks == '⌫') {
              _hapusSatuDigit();
            } else if (teks == '±') {
              _tekanPlusMinus();
            } else if (teks == ',') {
              _tekanKoma();
            } else if (isOperator) {
              _tekanOperator(teks);
            } else {
              _tekanAngka(teks);
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(70, 65),
            elevation: 0,
            backgroundColor: isHasil
                ? const Color(0xFF1FA98D)
                : isOperator
                    ? const Color(0xFFD8CCF3)
                    : isFungsi
                        ? const Color(0xFFE0E0E0)
                        : const Color(0xFFFCE4EC),
            foregroundColor: isHasil ? Colors.white : Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            teks,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _barisTombol(List<Widget> tombol) {
    return Expanded(child: Row(children: tombol));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // DISPLAY HASIL
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _isError ? Colors.red.shade400 : Colors.pink.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_expression.isNotEmpty)
                  Text(
                    _expression,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    _isError ? _display : _formatTampilan(_display),
                    style: TextStyle(
                      fontSize: _isError ? 22 : 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // TOMBOL KALKULATOR
          Expanded(
            child: Column(
              children: [
                _barisTombol([
                  _tombolKalkulator('±', isFungsi: true),
                  _tombolKalkulator(',', isFungsi: true),
                  _tombolKalkulator('⌫', isFungsi: true),
                  _tombolKalkulator('C', isFungsi: true),
                ]),
                _barisTombol([
                  _tombolKalkulator('7'),
                  _tombolKalkulator('8'),
                  _tombolKalkulator('9'),
                  _tombolKalkulator('÷', isOperator: true),
                ]),
                _barisTombol([
                  _tombolKalkulator('4'),
                  _tombolKalkulator('5'),
                  _tombolKalkulator('6'),
                  _tombolKalkulator('×', isOperator: true),
                ]),
                _barisTombol([
                  _tombolKalkulator('1'),
                  _tombolKalkulator('2'),
                  _tombolKalkulator('3'),
                  _tombolKalkulator('-', isOperator: true),
                ]),
                _barisTombol([
                  _tombolKalkulator('0', flex: 2),
                  _tombolKalkulator('=', isHasil: true),
                  _tombolKalkulator('+', isOperator: true),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}