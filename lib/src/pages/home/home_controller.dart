import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/company.dart';
import '../../services/company/company_service.dart';
part 'home_controller.g.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final _companyService = GetIt.I<CompanyService>();
  @readonly
  var _status = HomeStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  var _companies = <Company>[];

  Future<void> fetchCompanies() async {
    try {
      _status = HomeStatus.loading;
      _companies = await _companyService.fetchCompanies();
      _status = HomeStatus.loaded;
    } catch (e) {
      _status = HomeStatus.error;
      _errorMessage = 'Erro ao buscar empresas';
    }
  }
}
