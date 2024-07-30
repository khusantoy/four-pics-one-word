import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:four_pics_one_word/main.dart';

void main() {
  testWidgets("4 ta rasm borligini tekshirish", (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp());

    expect(find.byType(SizedBox), findsNWidgets(4));
  });
}
