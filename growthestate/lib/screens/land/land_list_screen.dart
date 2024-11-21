import 'package:flutter/material.dart';
import '../../providers/land_provider.dart';
import '../../models/land_model.dart';

class LandListScreen extends StatefulWidget {
  const LandListScreen({super.key});

  @override
  LandListScreenState createState() => LandListScreenState();
}

class LandListScreenState extends State<LandListScreen> {
  late Future<List<LandModel>> _landsFuture;

  @override
  void initState() {
    super.initState();
    _landsFuture = LandProvider().getAllLands(); // Fetch lands from the provider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Lands')),
      body: FutureBuilder<List<LandModel>>(
        future: _landsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lands available.'));
          }

          final lands = snapshot.data!;

          return ListView.builder(
            itemCount: lands.length,
            itemBuilder: (context, index) {
              final land = lands[index];
              return ListTile(
                title: Text(land.name),
                subtitle: Text('Location: ${land.location}'),
                trailing: Text('\$${land.pricePerUnit.toString()}'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/land_details',
                    arguments: land.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
