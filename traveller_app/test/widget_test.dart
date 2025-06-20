import 'package:flutter_test/flutter_test.dart';
import 'package:traveller_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with the correct title.
    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.text('Traveller'), findsOneWidget);

    // Verify that we have the search bar.
    expect(find.text('Cari rute perjalanan...'), findsOneWidget);

    // Verify that we have the bottom navigation bar.
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Booking'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
