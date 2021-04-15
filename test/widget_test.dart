import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_tunes/main.dart';
// import 'package:i_tunes/widgets/songs.dart';

void main() {
  testWidgets('Check search artist field', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // Build our app and trigger a frame.
    var textField = find.byType(TextField).first;
    await tester.enterText(textField, "Jake");
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump(Duration(seconds: 5));
    
    // Verify that our counter has incremented.
    // 400
    // expect(find.byType(Card).first, findsOneWidget);   
  });
}
