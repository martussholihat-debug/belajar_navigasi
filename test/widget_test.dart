
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:belajar_navigasi/main.dart';

void main() {
  testWidgets('Menu navigasi dan Project 14 tampil',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Navigasi Flutter'), findsOneWidget);

    final menuProject14 = find.text('14 - Form Tambah Mahasiswa');

    await tester.scrollUntilVisible(
      menuProject14,
      300,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.pumpAndSettle();

    expect(menuProject14, findsOneWidget);
    expect(find.text('Form, Controller & Validasi'), findsOneWidget);
  });
}
