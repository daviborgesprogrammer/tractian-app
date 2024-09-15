import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/restClient/rest_client.dart';
import '../../models/location.dart';
import './location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final _restClient = GetIt.I<RestClient>();
  @override
  Future<List<Location>> fetchLocations(String id) async {
    try {
      final Response(:data) = await _restClient.get('companies/$id/locations');
      return data.map<Location>((d) => Location.fromJson(d)).toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar localizações', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar localizações');
    }
  }
}
