import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';

class WithdrawalProvider with ChangeNotifier {
  String _status = '';
  String get status => _status;

  // Method to get the JWT token from SharedPreferences
  Future<String?> _getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.jwtTokenKey);
  }

  // Example method to make a withdrawal request
  Future<void> makeWithdrawal(double amount) async {
    final jwtToken = await _getJwtToken();

    if (jwtToken == null) {
      throw Exception('JWT token not found');
    }

    final url = Uri.parse('${Constants.baseUrl}/withdrawals');  // Using the baseUrl from constants

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',  // Add JWT token to the Authorization header
        },
        body: jsonEncode({'amount': amount}),
      );

      if (response.statusCode == 200) {
        // Handle successful withdrawal
        _status = 'Success';
        notifyListeners();
      } else {
        // Handle failure
        _status = 'Failed';
        notifyListeners();
        throw Exception('Failed to make withdrawal');
      }
    } catch (e) {
      _status = 'Error';
      notifyListeners();
      throw Exception('Error: $e');
    }
  }
}
