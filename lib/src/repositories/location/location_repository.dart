import '../../models/location.dart';
import 'location_repository_impl.dart';

abstract interface class LocationRepository {
  Future<List<Location>> fetchLocations(String id);

  factory LocationRepository() => LocationRepositoryImpl();
}
