import 'package:climora/presentation/modules/weather/widgets/forecast_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ForecastPreviewCard Widget Tests', () {
    testWidgets('should display correct content', (WidgetTester tester) async {
      // Arrange
      const lat = 40.7143;
      const lon = -74.006;
      const locationName = 'New York';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ForecastPreviewCard(
              lat: lat,
              lon: lon,
              locationName: locationName,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Extended forecast'), findsOneWidget);
      expect(find.text('View hourly and daily forecast'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should have correct widget structure', (
      WidgetTester tester,
    ) async {
      // Arrange
      const lat = 40.7143;
      const lon = -74.006;
      const locationName = 'New York';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ForecastPreviewCard(
              lat: lat,
              lon: lon,
              locationName: locationName,
            ),
          ),
        ),
      );

      // Assert - Check basic widget structure
      expect(find.byType(ForecastPreviewCard), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should be tappable without navigation', (
      WidgetTester tester,
    ) async {
      // Arrange
      const lat = 40.7143;
      const lon = -74.006;
      const locationName = 'New York';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ForecastPreviewCard(
              lat: lat,
              lon: lon,
              locationName: locationName,
            ),
          ),
        ),
      );

      final inkWellFinder = find.byType(InkWell);
      expect(inkWellFinder, findsOneWidget);

      // Test that the widget can be found and has InkWell for tap interaction
      final inkWell = tester.widget<InkWell>(inkWellFinder);
      expect(inkWell.onTap, isNotNull);
    });
  });
}
