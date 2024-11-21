import 'package:flutter/material.dart';

class LandScreen extends StatelessWidget {
  const LandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Lands')),
      body: ListView.builder(
        itemCount: 10, // Replace with the number of lands from your API
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.landscape),
            title: Text('Land #$index'),
            subtitle: const Text('Location: City Name, Size: 500 sqm'),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/land_details', arguments: index);
              },
              child: const Text('View'),
            ),
          );
        },
      ),
    );
  }
}
