// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

import 'package:rapor_lc/main.dart';

void main() {
  test('Tes JSON Serializable', () async {
    final mapel = MataPelajaran(0, Divisi(0, 'IT', 'Widi'), 'Aksel Programming');
    print(mapel.toJson());
  });
}
