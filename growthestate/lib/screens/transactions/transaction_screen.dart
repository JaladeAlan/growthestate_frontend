import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Transactions')),
      body: ListView.builder(
        itemCount: 10, // Replace with the number of transactions
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.receipt),
            title: Text('Transaction #$index'),
            subtitle: const Text('Status: Completed, Amount: \$500'),
            trailing: const Text(
              'View',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/transaction_details', arguments: index);
            },
          );
        },
      ),
    );
  }
}
