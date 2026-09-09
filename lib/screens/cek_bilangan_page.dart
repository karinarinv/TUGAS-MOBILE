import 'package:flutter/material.dart';

class CekBilanganPage extends StatefulWidget {
  const CekBilanganPage({super.key});

  @override
  State<CekBilanganPage> createState() => _CekBilanganPageState();
}

class _CekBilanganPageState extends State<CekBilanganPage> {
  final TextEditingController _controller = TextEditingController();
  int? _angkaDicek;
  bool? _isGenap;
  String? _errorText;

  void _cekBilangan() {
    final input = int.tryParse(_controller.text.trim());
    if (input == null) {
      setState(() {
        _errorText = 'Masukkan angka yang valid';
        _angkaDicek = null;
      });
      return;
    }
    setState(() {
      _errorText = null;
      _angkaDicek = input;
      _isGenap = input % 2 == 0;
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
          Text(
            'Cek Bilangan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[900],
            ),
          ),
          Text(
            'Cari tahu ganjil atau genap',
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
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'contoh: 17',
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
              onPressed: _cekBilangan,
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
                'Cek Bilangan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_angkaDicek != null) _buildHasilCard(),
        ],
      ),
    );
  }

  Widget _buildHasilCard() {
    final genap = _isGenap!;
    final warnaBg = genap ? const Color(0xFFE4F7EE) : const Color(0xFFFFE1EC);
    final warnaTeks = genap ? const Color(0xFF4CAF7D) : const Color(0xFFD93B68);
    final label = genap ? 'Genap' : 'Ganjil';
    final keterangan = genap
        ? 'habis dibagi 2, sisa 0'
        : 'tidak habis dibagi 2, sisa 1';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: warnaBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Bilangan $_angkaDicek',
            style: TextStyle(color: warnaTeks.withOpacity(0.75), fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: warnaTeks,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            keterangan,
            style: TextStyle(color: warnaTeks.withOpacity(0.75), fontSize: 12),
          ),
        ],
      ),
    );
  }
}