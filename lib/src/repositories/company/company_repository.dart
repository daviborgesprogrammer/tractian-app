import '../../models/company.dart';
import 'company_repository_impl.dart';

abstract interface class CompanyRepository {
  Future<List<Company>> fetchCompanies();

  factory CompanyRepository() {
    return CompanyRepositoryImpl();
  }
}
