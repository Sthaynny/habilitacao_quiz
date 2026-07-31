import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/bottom_nav_bar.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  testWidgets('BottomNavBar expõe rótulo e alvo mínimo 48dp por aba',
      (tester) async {
    var selected = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavBar(
            selectedIndex: selected,
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: Text(
                  Strings.quizzes,
                  style: AppFontStyle.body14Regular,
                ),
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.menu_book_outlined),
                title: Text(
                  Strings.aprender,
                  style: AppFontStyle.body14Regular,
                ),
              ),
            ],
            onItemSelected: (index) => selected = index,
          ),
        ),
      ),
    );

    final inkWells = find.byType(InkWell);
    expect(inkWells, findsNWidgets(2));

    final semantics = tester.getSemantics(inkWells.first);
    expect(semantics.label, Strings.quizzes);
    expect(semantics.flagsCollection.isSelected, Tristate.isTrue);

    final box = tester.renderObject<RenderBox>(inkWells.first);
    expect(box.size.height, greaterThanOrEqualTo(48));
    expect(box.size.width, greaterThanOrEqualTo(48));
  });
}
