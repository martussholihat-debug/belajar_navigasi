// ============================================================================
//  MENU GABUNGAN - NAVIGASI ANTAR HALAMAN (versi file terpisah)
//  Setiap project berada di file sendiri pada folder lib/projects/.
//  File ini hanya berisi menu untuk membuka ke-13 project.
//
//  Cara menjalankan:
//     flutter run                                   (menu gabungan)
//     flutter run -t lib/projects/p01_navigator_dasar.dart   (satu project)
// ============================================================================

import 'package:flutter/material.dart';
import 'common/app_common.dart';
import 'projects/p14_form_mahasiswa.dart' show Project14FormMahasiswa;
import 'projects/p01_navigator_dasar.dart' show Project01Dasar;
import 'projects/p02_kirim_data.dart' show Project02KirimData;
import 'projects/p03_terima_hasil.dart' show Project03Hasil;
import 'projects/p04_named_routes.dart' show Project04NamedRoute, p4Routes;
import 'projects/p05_arguments.dart' show Project05Arguments, p5Routes;
import 'projects/p06_login_home.dart' show Project06Login;
import 'projects/p07_tumpukan_halaman.dart' show Project07Tumpukan;
import 'projects/p08_bottom_nav.dart' show Project08BottomNav;
import 'projects/p09_tabbar.dart' show Project09TabBar;
import 'projects/p10_drawer.dart' show Project10Drawer;
import 'projects/p11_hero.dart' show Project11Hero;
import 'projects/p12_transisi_custom.dart' show Project12Transisi;
import 'projects/p13_mini_toko.dart' show Project13Login;

void main() {
  runApp(const MyApp());
}

// ----------------------------------------------------------------------------
// MyApp : root aplikasi.
// `routes` menggabungkan route bernama dari Project 04 dan Project 05.
// ----------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Navigasi',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const DaftarProject(),
      // ... = spread: memasukkan seluruh isi map ke dalam map ini
      routes: {
        ...p4Routes,
        ...p5Routes,
      },
    );
  }
}

// ----------------------------------------------------------------------------
// Model 1 baris menu project
// ----------------------------------------------------------------------------
class ItemProject {
  final String judul;
  final String konsep;
  final Widget halaman;

  ItemProject(this.judul, this.konsep, this.halaman);
}

// ----------------------------------------------------------------------------
// DaftarProject : menu berisi 13 project (ini adalah halaman PALING BAWAH di
// tumpukan Navigator).
// ----------------------------------------------------------------------------
class DaftarProject extends StatelessWidget {
  const DaftarProject({super.key});

  @override
  Widget build(BuildContext context) {
    final daftar = <ItemProject>[
      ItemProject('01 - Navigator Dasar', 'push & pop', const Project01Dasar()),
      ItemProject('02 - Kirim Data', 'data lewat constructor', const Project02KirimData()),
      ItemProject('03 - Terima Hasil', 'pop(hasil) + await', const Project03Hasil()),
      ItemProject('04 - Named Routes', 'pushNamed', const Project04NamedRoute()),
      ItemProject('05 - Named + Arguments', 'arguments & ModalRoute', const Project05Arguments()),
      ItemProject('06 - Login -> Home', 'pushReplacement', const Project06Login()),
      ItemProject('07 - Tumpukan Halaman', 'popUntil, pushAndRemoveUntil', const Project07Tumpukan(level: 1)),
      ItemProject('08 - Bottom Navigation', 'NavigationBar + IndexedStack', const Project08BottomNav()),
      ItemProject('09 - TabBar', 'TabBar & TabBarView', const Project09TabBar()),
      ItemProject('10 - Drawer', 'menu samping', const Project10Drawer()),
      ItemProject('11 - Hero Animation', 'transisi antar halaman', const Project11Hero()),
      ItemProject('12 - Transisi Custom', 'PageRouteBuilder', const Project12Transisi()),
      ItemProject('13 - Mini Toko', 'GABUNGAN semua konsep', const Project13Login()),
      ItemProject(
        '14 - Form Tambah Mahasiswa',
        'Form, Controller & Validasi',
        const Project14FormMahasiswa(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigasi Flutter'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: daftar.length,
        itemBuilder: (context, i) {
          final p = daftar[i];
          return ListTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text(p.judul),
            subtitle: Text(p.konsep),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // PUSH: letakkan halaman project di atas tumpukan.
              // MaterialPageRoute = "bungkus" halaman dengan animasi
              // perpindahan standar Android/iOS.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => p.halaman),
              );
            },
          );
        },
      ),
    );
  }
}