
import 'package:flutter/material.dart';
import '../common/app_common.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const Project01Dasar(),
    ),
  );
}

// PROJECT 01 - NAVIGATOR DASAR

// HALAMAN A
class Project01Dasar extends StatelessWidget {
  const Project01Dasar({super.key});

  @override
  Widget build(BuildContext context) {
    return Halaman(
      judul: '01 - Halaman A',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.looks_one, size: 100, color: Colors.teal),
            const Text('Ini HALAMAN A',
                style: TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                Text(
                  'canPop: ${Navigator.canPop(context)}',
                ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const P1HalamanB(),
                  ),
                );
              },
              child: const Text('Buka Halaman B'),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN B
class P1HalamanB extends StatelessWidget {
  const P1HalamanB({super.key});

  @override
  Widget build(BuildContext context) {
    return Halaman(
      judul: '01 - Halaman B',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.looks_two, size: 100, color: Colors.orange),
            const Text('Ini HALAMAN B',
                style: TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                  Text(
                    'canPop: ${Navigator.canPop(context)}',
                  ),
            const SizedBox(height: 20),

            // Kembali ke A
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali ke A'),
            ),

            const SizedBox(height: 10),

            // Membuka Halaman C
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const P1HalamanC(),
                  ),
                );
              },
              child: const Text('Buka C'),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN C
class P1HalamanC extends StatelessWidget {
  const P1HalamanC({super.key});

  @override
  Widget build(BuildContext context) {
    return Halaman(
      judul: '01 - Halaman C',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.looks_3, size: 100, color: Colors.purple),
            const Text('Ini HALAMAN C',
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),

            // Kembali langsung ke A
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup C
                Navigator.pop(context); // Tutup B
              },
              child: const Text('Kembali ke A'),
            ),
          ],
        ),
      ),
    );
  }
}