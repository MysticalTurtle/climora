import 'package:climora/core/core.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceI implements LocationService {
  @override
  Future<LocationPermission> checkAndRequestPermissions() async {
    // Check current permission
    final permission = await checkPermission();

    // Request permission if denied
    if (permission == LocationPermission.denied) {
      return Geolocator.requestPermission();
    }

    return permission;
  }

  @override
  Future<Position?> getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<LocationPermission> checkPermission() async {
    return Geolocator.checkPermission();
  }
}
