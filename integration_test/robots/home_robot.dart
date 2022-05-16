import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  final WidgetTester tester;

  HomeRobot(this.tester);

  Future<void> clickNavigationDrawerButton() async {
    final drawerButtonFinder = find.byKey(Key('drawer_button'));

    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);

    await tester.pumpAndSettle();
  }
}
