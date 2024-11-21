import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final int transactionId;

  const TransactionDetailsScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Transaction ID: $transactionId'),
            const Text('Type: Purchase'),
            const Text('Amount: \$500'),
            const Text('Status: Completed'),
            const SizedBox(height: 20),
            const Text(
              'Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('Date: 2024-11-20'),
            const Text('Units Purchased: 10'),
            const Text('Land ID: 5'),
          ],
        ),
      ),
    );
  }
}
