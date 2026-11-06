
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Project14FormMahasiswa extends StatefulWidget {
  const Project14FormMahasiswa({super.key});

  @override
  State<Project14FormMahasiswa> createState() =>
      _Project14FormMahasiswaState();
}

class _Project14FormMahasiswaState
    extends State<Project14FormMahasiswa> {
  final _formKey = GlobalKey<FormState>();

  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  final _emailC = TextEditingController();
  final _semC = TextEditingController();

  final _namaF = FocusNode();
  final _nimF = FocusNode();
  final _emailF = FocusNode();
  final _semF = FocusNode();

  AutovalidateMode _mode = AutovalidateMode.disabled;
  Map<String, String>? _hasil;

  @override
  void dispose() {
    _namaC.dispose();
    _nimC.dispose();
    _emailC.dispose();
    _semC.dispose();

    _namaF.dispose();
    _nimF.dispose();
    _emailF.dispose();
    _semF.dispose();

    super.dispose();
  }

  // Validasi Nama
  String? validasiNama(String? val) {
    final t = val?.trim() ?? '';

    if (t.isEmpty) {
      return 'Nama wajib diisi';
    }

    if (t.length < 3) {
      return 'Nama minimal 3 huruf';
    }

    return null;
  }

  // Validasi NIM
  String? validasiNim(String? val) {
    final t = val?.trim() ?? '';

    if (t.isEmpty) {
      return 'NIM wajib diisi';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(t)) {
      return 'NIM hanya boleh berisi angka';
    }

    if (t.length < 7) {
      return 'NIM minimal 7 digit';
    }

    return null;
  }

  // Validasi Email
  String? validasiEmail(String? val) {
    final t = val?.trim() ?? '';

    if (t.isEmpty) {
      return 'Email wajib diisi';
    }

    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$')
        .hasMatch(t)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // Validasi Semester
  String? validasiSemester(String? val) {
    final t = val?.trim() ?? '';

    if (t.isEmpty) {
      return 'Semester wajib diisi';
    }

    final angka = int.tryParse(t);

    if (angka == null) {
      return 'Semester harus berupa angka';
    }

    if (angka < 1 || angka > 14) {
      return 'Semester harus antara 1 dan 14';
    }

    return null;
  }

  // Fungsi Simpan
  void _simpan() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _hasil = {
          'nama': _namaC.text.trim(),
          'nim': _nimC.text.trim(),
          'email': _emailC.text.trim(),
          'semester': _semC.text.trim(),
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data ${_hasil!['nama']} berhasil disimpan.',
          ),
        ),
      );
    } else {
      setState(() {
        _mode = AutovalidateMode.onUserInteraction;
        _hasil = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Periksa kembali isian yang ditandai merah.',
          ),
        ),
      );
    }
  }

  // Fungsi Kosongkan
  void _kosongkan() {
    _formKey.currentState?.reset();

    _namaC.clear();
    _nimC.clear();
    _emailC.clear();
    _semC.clear();

    setState(() {
      _hasil = null;
      _mode = AutovalidateMode.disabled;
    });

    _namaF.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: _mode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kolom Nama
              TextFormField(
                controller: _namaC,
                focusNode: _namaF,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_nimF);
                },
                decoration: const InputDecoration(
                  labelText: 'Nama lengkap',
                  hintText: 'mis. Rina Amelia',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: validasiNama,
              ),

              const SizedBox(height: 16),

              // Kolom NIM
              TextFormField(
                controller: _nimC,
                focusNode: _nimF,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 12,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailF);
                },
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  hintText: 'Hanya angka',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                validator: validasiNim,
              ),

              const SizedBox(height: 8),

              // Kolom Email
              TextFormField(
                controller: _emailC,
                focusNode: _emailF,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_semF);
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'nama@kampus.ac.id',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: validasiEmail,
              ),

              const SizedBox(height: 16),

              // Kolom Semester
              TextFormField(
                controller: _semC,
                focusNode: _semF,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 2,
                decoration: const InputDecoration(
                  labelText: 'Semester',
                  hintText: '1 sampai 14',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                validator: validasiSemester,
                onFieldSubmitted: (_) => _simpan(),
              ),

              const SizedBox(height: 16),

              // Tombol Simpan
              FilledButton.icon(
                onPressed: _simpan,
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
              ),

              const SizedBox(height: 8),

              // Tombol Kosongkan
              OutlinedButton.icon(
                onPressed: _kosongkan,
                icon: const Icon(Icons.refresh),
                label: const Text('Kosongkan'),
              ),

              // Pratinjau Data
              if (_hasil != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Pratinjau data valid',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BarisInfo(
                        label: 'Nama',
                        nilai: _hasil!['nama']!,
                      ),
                      BarisInfo(
                        label: 'NIM',
                        nilai: _hasil!['nim']!,
                      ),
                      BarisInfo(
                        label: 'Email',
                        nilai: _hasil!['email']!,
                      ),
                      BarisInfo(
                        label: 'Semester',
                        nilai: _hasil!['semester']!,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk menampilkan informasi mahasiswa
class BarisInfo extends StatelessWidget {
  const BarisInfo({
    super.key,
    required this.label,
    required this.nilai,
  });

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(nilai),
          ),
        ],
      ),
    );
  }
}
