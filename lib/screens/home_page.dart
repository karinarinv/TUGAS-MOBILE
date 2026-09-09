import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data kelompok disimpan statis di sini.
  // Ganti sesuai anggota kelompok kamu masing-masing.
  final List<Map<String, String>> anggota = const [
    {'role': 'Ketua', 'nama': 'Putri Karina Tumanggor', 'nim': '124240047'},
    {'role': 'Anggota', 'nama': 'Bagas Prayoga', 'nim': '21120xxx'},
    {'role': 'Anggota', 'nama': 'Citra Dewi', 'nim': '21120xxx'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kelompok 3',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '${anggota.length} anggota terdaftar',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: anggota.length,
              itemBuilder: (context, index) {
                final data = anggota[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          data['nama']![0],
                          style: TextStyle(
                            color: Colors.pink[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['role']!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[300],
                            ),
                          ),
                          Text(
                            data['nama']!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'NIM ${data['nim']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}