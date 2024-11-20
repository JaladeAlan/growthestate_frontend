import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';  

class TransactionProvider with ChangeNotifier {
  List<dynamic> _transactions = [];
  List<dynamic> get transactions => _transactions;

  String _status = '';
  String get status => _status;

  // Method to get the JWT token from SharedPreferences
  Future<String?> _getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.jwtTokenKey);
  }

  // Method to fetch transactions from the API
  Future<void> fetchTransactions() async {
    final jwtToken = await _getJwtToken();

    if (jwtToken == null) {
      throw Exception('JWT token not found');
    }

    final url = Uri.parse('${Constants.baseUrl}/transactions');  // Using the baseUrl from constants

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',  // Add JWT token to the Authorization header
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _transactions = data['transactions'];  // Assuming the response contains a 'transactions' field
        _status = 'Success';
        notifyListeners();
      } else {
        _status = 'Failed to fetch transactions';
        notifyListeners();
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      _status = 'Error';
      notifyListeners();
      throw Exception('Error: $e');
    }
  }

  // Method to create a new transaction
  Future<void> createTransaction(double amount, String description) async {
    final jwtToken = await _getJwtToken();

    if (jwtToken == null) {
      throw Exception('JWT token not found');
    }

    final url = Uri.parse('${Constants.baseUrl}/transactions');  // Using the baseUrl from constants

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',  // Add JWT token to the Authorization header
        },
        body: jsonEncode({
          'amount': amount,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        _status = 'Transaction created successfully';
        notifyListeners();
        await fetchTransactions();  // Optionally refresh the transaction list
      } else {
        _status = 'Failed to create transaction';
        notifyListeners();
        throw Exception('Failed to create transaction');
      }
    } catch (e) {
      _status = 'Error';
      notifyListeners();
      throw Exception('Error: $e');
    }
  }
}
