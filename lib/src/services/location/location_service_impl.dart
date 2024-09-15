import 'package:get_it/get_it.dart';

import '../../models/location.dart';
import '../../repositories/location/location_repository.dart';
import './location_service.dart';

class LocationServiceImpl implements LocationService {
  final _locationRepository = GetIt.I<LocationRepository>();

  @override
  Future<List<Location>> fetchLocations(String id) =>
      _locationRepository.fetchLocations(id);
}
