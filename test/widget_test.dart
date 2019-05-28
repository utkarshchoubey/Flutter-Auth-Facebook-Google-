//// This is a basic Flutter widget test.
////
//// To perform an interaction with a widget in your test, use the WidgetTester
//// utility that Flutter provides. For example, you can send tap and scroll
//// gestures. You can also use WidgetTester to find child widgets in the widget
//// tree, read text, and verify that the values of widget properties are correct.
//
//import 'package:flutter/material.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter_demo/landing_page.dart';
//import 'package:flutter_demo/main.dart';
//import 'package:flutter_demo/emailAuth/pages/root_page.dart';
//import 'package:flutter_demo/emailAuth/services/authentication.dart';
//
//
//void main() {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//
//    await tester.pumpWidget(RootPage(auth: new Auth()));
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
//}



import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create our Finders
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}