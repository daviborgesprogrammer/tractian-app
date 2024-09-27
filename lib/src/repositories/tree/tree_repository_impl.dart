import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/restClient/rest_client.dart';
import '../../models/asset.dart';
import '../../models/location.dart';
import './tree_repository.dart';

class TreeRepositoryImpl implements TreeRepository {
  final _restClient = GetIt.I<RestClient>();

  @override
  Future<List<Asset>> fetchAssets(String id) async {
    try {
      final Response(:data) = await _restClient.get('/companies/$id/assets');
      return data.map<Asset>((d) => Asset.fromJson(d)).toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar ativos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar ativos');
    }
  }

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
