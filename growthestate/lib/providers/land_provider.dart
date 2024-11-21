import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../models/land_model.dart';

class LandProvider {
  Future<List<LandModel>> getAllLands() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/lands'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((land) => LandModel.fromJson(land)).toList();
    } else {
      throw Exception('Failed to load lands');
    }
  }

  Future<LandModel> getLandDetails(int landId) async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/lands/$landId'));

    if (response.statusCode == 200) {
      return LandModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load land details');
    }
  }
}
