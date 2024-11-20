import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';  // Import constants for the base URL and token key

class PurchaseProvider with ChangeNotifier {
  List<dynamic> _purchases = [];
  List<dynamic> get purchases => _purchases;

  String _status = '';
  String get status => _status;

  // Get JWT token from SharedPreferences
  Future<String?> _getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.jwtTokenKey);
  }

  // Fetch purchases from the API
  Future<void> fetchPurchases() async {
    final jwtToken = await _getJwtToken();
    
    if (jwtToken == null) {
      throw Exception('JWT token not found');
    }

    final url = Uri.parse('${Constants.baseUrl}/purchases');  // API endpoint for purchases

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',  // Send JWT in headers
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _purchases = data['purchases'];  // Assuming the response contains 'purchases'
        _status = 'Success';
        notifyListeners();
      } else {
        _status = 'Failed to fetch purchases';
        notifyListeners();
        throw Exception('Failed to fetch purchases');
      }
    } catch (e) {
      _status = 'Error';
      notifyListeners();
      throw Exception('Error: $e');
    }
  }

  // Create a purchase (buy land)
  Future<void> createPurchase(int landId, int units, double totalAmount) async {
    final jwtToken = await _getJwtToken();

    if (jwtToken == null) {
      throw Exception('JWT token not found');
    }

    final url = Uri.parse('${Constants.baseUrl}/purchases');  // API endpoint for creating a purchase

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',  // Send JWT in headers
        },
        body: jsonEncode({
          'land_id': landId,
          'units': units,
          'total_amount_paid': totalAmount,
        }),
      );

      if (response.statusCode == 200) {
        _status = 'Purchase successful';
        notifyListeners();
        await fetchPurchases();  // Optionally refresh the list after a successful purchase
      } else {
        _status = 'Failed to make purchase';
        notifyListeners();
        throw Exception('Failed to make purchase');
      }
    } catch (e) {
      _status = 'Error';
      notifyListeners();
      throw Exception('Error: $e');
    }
  }
}
