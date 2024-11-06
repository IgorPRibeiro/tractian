import 'package:flutter/material.dart';
import 'package:tractian/src/models/companies_model.dart';
import 'package:tractian/src/repository/companies_repository.dart';
import 'package:tractian/src/states/companies_state.dart';

class CompaniesStore extends ValueNotifier<CompaniesState> {

  CompaniesStore(): super(CompaniesState.init());
  final repository = CompaniesRepository();

  Future<void> getCompanies() async {
    final listCompanies = await repository.getCompanies();
    value = value.copyWith(companies: listCompanies);
  }

  Future<void> selectCompanies(CompaniesModel companies) async {
    value = value.copyWith(companiesSelected: companies);
  }


}