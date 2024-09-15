import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/restClient/rest_client.dart';
import '../../models/company.dart';
import './company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final _restClient = GetIt.I<RestClient>();
  @override
  Future<List<Company>> fetchCompanies() async {
    try {
      final Response(:data) = await _restClient.get('companies');
      return data.map<Company>((d) => Company.fromJson(d)).toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar empresas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar empresas');
    }
  }
}
