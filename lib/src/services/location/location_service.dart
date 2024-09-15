import '../../models/location.dart';
import 'location_service_impl.dart';

abstract interface class LocationService {
  Future<List<Location>> fetchLocations(String id);

  factory LocationService() => LocationServiceImpl();
}
