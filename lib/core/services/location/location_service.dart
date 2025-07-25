import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// Check and request location permissions
  Future<LocationPermission> checkAndRequestPermissions();
  
  /// Get current device coordinates
  Future<Position?> getCurrentPosition();
  
  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();
  
  /// Check current permission status without requesting
  Future<LocationPermission> checkPermission();
}
