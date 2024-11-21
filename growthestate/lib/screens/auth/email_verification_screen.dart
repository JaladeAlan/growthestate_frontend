import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/api_endpoints.dart';
import '../../utils/logger_util.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _verificationCodeController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  Future<void> _verifyEmail() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/email/verify/code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': _verificationCodeController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _message = 'Email verified successfully.');
        AppLogger.i('Email verification successful');
        if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        setState(() => _message = 'Invalid verification code. Please try again.');
      }
    } catch (error) {
      AppLogger.e('Error during email verification', error);
      setState(() => _message = 'An error occurred.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resendVerificationCode() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/email/resend-verification'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() => _message = 'Verification code sent successfully.');
        AppLogger.i('Verification code resent');
      } else {
        setState(() => _message = 'Failed to resend verification code.');
      }
    } catch (error) {
      AppLogger.e('Error during code resend', error);
      setState(() => _message = 'An error occurred.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _verificationCodeController, decoration: const InputDecoration(labelText: 'Verification Code')),
            const SizedBox(height: 16),
            if (_message != null) Text(_message!, style: TextStyle(color: _message!.contains('success') ? Colors.green : Colors.red)),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _verifyEmail, child: const Text('Verify Email')),
            const SizedBox(height: 16),
            TextButton(onPressed: _resendVerificationCode, child: const Text('Resend Code')),
          ],
        ),
      ),
    );
  }
}
