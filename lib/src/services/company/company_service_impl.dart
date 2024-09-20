import 'package:get_it/get_it.dart';

import '../../core/restClient/local_client.dart';
import '../../models/company.dart';
import '../../repositories/company/company_repository.dart';
import './company_service.dart';

class CompanyServiceImpl implements CompanyService {
  final _companyRepository = GetIt.I<CompanyRepository>();
  @override
  Future<List<Company>> fetchCompanies({bool offline = false}) async {
    return offline
        ? fetchLocalCompanies()
        : _companyRepository.fetchCompanies();
  }

  Future<List<Company>> fetchLocalCompanies() async {
    final data = await LocalClient().get('companies');
    return data.map<Company>((d) => Company.fromJson(d)).toList();
  }
}
