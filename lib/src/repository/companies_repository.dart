import 'dart:convert';

import 'package:tractian/src/models/companies_model.dart';
import 'package:http/http.dart';

class CompaniesRepository {
  final client = Client();

  Future<List<CompaniesModel>> getCompanies() async {
    final response = await client.get(Uri.parse('http://fake-api.tractian.com/companies'));
    final jsonRaw = response.body;
    return parseCompanies(jsonRaw);
  }

  List<CompaniesModel> parseCompanies(String jsonRaw) {
    final List<dynamic> jsonList = jsonDecode(jsonRaw);
    return jsonList.map((json) => CompaniesModel.fromJson(json)).toList();
  }


}