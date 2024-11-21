import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/api_endpoints.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  // Function to log out the user by calling the logout API and clearing the session
  Future<void> _logout() async {
    try {
      // Get the JWT token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token'); // Replace with your token key

      if (token == null) {
        throw Exception('No token found');
      }

      // Make a POST request to the Laravel logout API
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/logout'), // Use the baseUrl from Constants
        headers: {
          'Authorization': 'Bearer $token', // Attach the JWT token
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Clear the JWT token from SharedPreferences
        await prefs.remove('jwt_token');

        // Ensure the widget is still mounted before navigating
        if (!mounted) return;

        // Navigate to login screen after successful logout
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Handle API error (if response status code is not 200)
        throw Exception('Failed to log out');
      }
    } catch (error) {
      // Ensure the widget is still mounted before showing a dialog
      if (!mounted) return;

      // Show error dialog if any error occurs during logout
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout Failed'),
            content: Text('An error occurred: $error'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the error dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GrowthEstate Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Trigger logout
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lands');
              },
              child: const Text('View Lands'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transactions');
              },
              child: const Text('View Transactions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/deposit');
              },
              child: const Text('Deposit Funds'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/withdraw');
              },
              child: const Text('Withdraw Funds'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text('Profile Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
