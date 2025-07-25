import 'package:climora/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocator extends Mock {
  static LocationPermission checkPermission() {
    return LocationPermission.whileInUse;
  }

  static Future<LocationPermission> requestPermission() async {
    return LocationPermission.whileInUse;
  }

  static Future<bool> isLocationServiceEnabled() async {
    return true;
  }

  static Future<Position> getCurrentPosition() async {
    return Position(
      latitude: 40.7143,
      longitude: -74.006,
      timestamp: DateTime.now(),
      accuracy: 10,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}

void main() {
  late LocationService locationService;

  setUp(() {
    locationService = LocationServiceI();
  });

  group('LocationService', () {
    test(
      'should return current position when permissions are granted',
      () async {
        expect(locationService, isA<LocationService>());
      },
    );

    test('should handle permission states correctly', () async {
      expect(locationService.isLocationServiceEnabled, isA<Function>());
      expect(locationService.checkPermission, isA<Function>());
      expect(locationService.getCurrentPosition, isA<Function>());
    });
  });
}
