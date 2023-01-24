import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/home.dart';

Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('Test Widget Home Page', () {

    testWidgets('Testing si muestra el ListView', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Scrolling', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen()); //Este renderiza el widget para probar
      expect(find.text('Item 0'), findsOneWidget);
      await tester.fling(find.byType(ListView),  Offset(0, -800), 3000);
      await tester.pumpAndSettle(); //Esto espera que se resuelvan todos los Frames IU
      expect(find.text('Item 0'), findsNothing);
    });
  });
  testWidgets('Testing IconButtons', (tester) async {
    await tester.pumpWidget(createHomeScreen());

    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.text('Added to favorites.'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.text('Removed from favorites.'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

}
