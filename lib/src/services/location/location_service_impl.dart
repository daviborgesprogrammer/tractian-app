import 'package:get_it/get_it.dart';

import '../../core/restClient/local_client.dart';
import '../../models/location.dart';
import '../../repositories/location/location_repository.dart';
import './location_service.dart';

class LocationServiceImpl implements LocationService {
  final _locationRepository = GetIt.I<LocationRepository>();

  @override
  Future<List<Location>> fetchLocations(String id, {bool offline = false}) =>
      offline
          ? fetchLocalLocations(id)
          : _locationRepository.fetchLocations(id);

  Future<List<Location>> fetchLocalLocations(String id) async {
    final data = await LocalClient().get(id, 'locations');
    return data.map<Location>((d) => Location.fromJson(d)).toList();
  }
}
