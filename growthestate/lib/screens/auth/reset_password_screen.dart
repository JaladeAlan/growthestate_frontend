import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/api_endpoints.dart';
import '../../utils/logger_util.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  Future<void> _resetPassword() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/password/reset'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': _resetCodeController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _message = 'Password reset successfully. Please log in.');
        AppLogger.i('Password reset successful');
        if (mounted) Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() => _message = 'Failed to reset password. Please check your reset code.');
      }
    } catch (error) {
      AppLogger.e('Error during password reset', error);
      setState(() => _message = 'An error occurred.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _resetCodeController, decoration: const InputDecoration(labelText: 'Reset Code')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 16),
            if (_message != null) Text(_message!, style: TextStyle(color: _message!.contains('success') ? Colors.green : Colors.red)),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _resetPassword, child: const Text('Reset Password')),
          ],
        ),
      ),
    );
  }
}
