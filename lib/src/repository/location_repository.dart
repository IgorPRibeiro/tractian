import 'dart:convert';

import 'package:http/http.dart';
import 'package:tractian/src/models/location_model.dart';

class LocationRepository {
  final client = Client();
  
  Future<List<LocationModel>> getLocations(String idCompanies) async {
    final response = await client.get(Uri.parse("http://fake-api.tractian.com/companies/$idCompanies/locations"));
    final jsonRaw = response.body;
    return parseLocations(jsonRaw);
  }
  
  List<LocationModel> parseLocations(String jsonRaw) {
    final List<dynamic> jsonList = jsonDecode(jsonRaw);
    return jsonList.map((json) => LocationModel.fromJson(json)).toList();
  }
  
      
}