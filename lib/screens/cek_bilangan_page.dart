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
          const Text(
            'Cek Bilangan',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Cari tahu ganjil atau genap',
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
              hintText: 'contoh: 17',
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
              onPressed: _cekBilangan,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.pink[300],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Cek Bilangan'),
            ),
          ),
          const SizedBox(height: 20),
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
    final icon = genap ? '🍃' : '🌸';
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
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Text(icon, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(height: 8),
          Text(
            'Bilangan $_angkaDicek',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: warnaTeks,
            ),
          ),
          Text(
            keterangan,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}