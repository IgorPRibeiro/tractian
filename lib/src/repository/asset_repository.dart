import 'dart:convert';

import 'package:http/http.dart';
import 'package:tractian/src/models/assets_model.dart';

class AssetRepository {
  final client = Client();

  Future<List<AssetsModel>> getAssets(String idCompanies) async {
    final response = await client.get(Uri.parse("http://fake-api.tractian.com/companies/$idCompanies/assets"));
    final jsonRaw = response.body;
    return parseCompanies(jsonRaw);
  }

  List<AssetsModel> parseCompanies(String jsonRaw) {
    final List<dynamic> jsonList = jsonDecode(jsonRaw);
    return jsonList.map((json) => AssetsModel.fromJson(json)).toList();
  }


}