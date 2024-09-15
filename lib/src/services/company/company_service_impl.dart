import 'package:get_it/get_it.dart';

import '../../models/company.dart';
import '../../repositories/company/company_repository.dart';
import './company_service.dart';

class CompanyServiceImpl implements CompanyService {
  final _companyRepository = GetIt.I<CompanyRepository>();
  @override
  Future<List<Company>> fetchCompanies() async {
    return _companyRepository.fetchCompanies();
  }
}
