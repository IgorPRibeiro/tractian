import 'package:test/test.dart';
import 'package:tractian/src/repository/companies_repository.dart';


void main() {
  test('get all companies', () async {
    final repository = CompaniesRepository();
    final companies = await repository.getCompanies();
    print(companies);
  });
}