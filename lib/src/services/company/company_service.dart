import '../../models/company.dart';
import 'company_service_impl.dart';

abstract interface class CompanyService {
  Future<List<Company>> fetchCompanies({bool offline = false});

  factory CompanyService() => CompanyServiceImpl();
}
