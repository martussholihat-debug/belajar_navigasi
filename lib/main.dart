
import 'package:flutter/material.dart';
import 'common/app_common.dart';

import 'projects/p14_form_mahasiswa.dart'
    show Project14FormMahasiswa;
import 'projects/p01_navigator_dasar.dart'
    show Project01Dasar;
import 'projects/p02_kirim_data.dart'
    show Project02KirimData;
import 'projects/p03_terima_hasil.dart'
    show Project03Hasil;
import 'projects/p04_named_routes.dart'
    show Project04NamedRoute, p4Routes;
import 'projects/p05_arguments.dart'
    show Project05Arguments, p5Routes;
import 'projects/p06_login_home.dart'
    show Project06Login;
import 'projects/p07_tumpukan_halaman.dart'
    show Project07Tumpukan;
import 'projects/p08_bottom_nav.dart'
    show Project08BottomNav;
import 'projects/p09_tabbar.dart'
    show Project09TabBar;
import 'projects/p10_drawer.dart'
    show Project10Drawer;
import 'projects/p11_hero.dart'
    show Project11Hero;
import 'projects/p12_transisi_custom.dart'
    show Project12Transisi;
import 'projects/p13_mini_toko.dart'
    show Project13Login;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Navigasi',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const DaftarProject(),
      routes: {
        ...p4Routes,
        ...p5Routes,
      },
    );
  }
}

class ItemProject {
  final String judul;
  final String konsep;
  final Widget halaman;

  ItemProject(this.judul, this.konsep, this.halaman);
}

class DaftarProject extends StatelessWidget {
  const DaftarProject({super.key});

  @override
  Widget build(BuildContext context) {
    final daftar = <ItemProject>[
      ItemProject(
        '01 - Navigator Dasar',
        'push & pop',
        const Project01Dasar(),
      ),
      ItemProject(
        '02 - Kirim Data',
        'data lewat constructor',
        const Project02KirimData(),
      ),
      ItemProject(
        '03 - Terima Hasil',
        'pop(hasil) + await',
        const Project03Hasil(),
      ),
      ItemProject(
        '04 - Named Routes',
        'pushNamed',
        const Project04NamedRoute(),
      ),
      ItemProject(
        '05 - Named + Arguments',
        'arguments & ModalRoute',
        const Project05Arguments(),
      ),
      ItemProject(
        '06 - Login -> Home',
        'pushReplacement',
        const Project06Login(),
      ),
      ItemProject(
        '07 - Tumpukan Halaman',
        'popUntil, pushAndRemoveUntil',
        const Project07Tumpukan(level: 1),
      ),
      ItemProject(
        '08 - Bottom Navigation',
        'NavigationBar + IndexedStack',
        const Project08BottomNav(),
      ),
      ItemProject(
        '09 - TabBar',
        'TabBar & TabBarView',
        const Project09TabBar(),
      ),
      ItemProject(
        '10 - Drawer',
        'menu samping',
        const Project10Drawer(),
      ),
      ItemProject(
        '11 - Hero Animation',
        'transisi antar halaman',
        const Project11Hero(),
      ),
      ItemProject(
        '12 - Transisi Custom',
        'PageRouteBuilder',
        const Project12Transisi(),
      ),
      ItemProject(
        '13 - Mini Toko',
        'GABUNGAN semua konsep',
        const Project13Login(),
      ),
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
            leading: CircleAvatar(
              child: Text('${i + 1}'),
            ),
            title: Text(p.judul),
            subtitle: Text(p.konsep),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => p.halaman,
                ),
              );
            },
          );
        },
      ),

      // Tombol Tambah Mahasiswa di halaman utama
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const Project14FormMahasiswa(),
            ),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Tambah Mahasiswa'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
    );
  }
}
