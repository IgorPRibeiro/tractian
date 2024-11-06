import 'package:tractian/src/models/companies_model.dart';

class CompaniesState {
  final List<CompaniesModel> companies;
  final CompaniesModel? companiesSelected;

  CompaniesState({required this.companies,required this.companiesSelected});
  
  factory CompaniesState.init() {
    return CompaniesState(
      companies: const [],
      companiesSelected: CompaniesModel.init()
    );
  }

  CompaniesState copyWith({List<CompaniesModel>? companies, CompaniesModel? companiesSelected}) {
    return CompaniesState(companies: companies ?? this.companies, companiesSelected: null);
  }
  
}