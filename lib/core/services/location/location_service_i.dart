import 'package:climora/core/services/location/location_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceI implements LocationService {
  @override
  Future<LocationPermission> checkAndRequestPermissions() async {
    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Los servicios de ubicación están desactivados');
    }

    final permission = await checkPermission();

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
      throw Exception('Error obteniendo ubicación: $e');
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
