import 'package:flutter/material.dart';
import '../../providers/land_provider.dart';
import '../../models/land_model.dart';

class LandDetailScreen extends StatefulWidget {
  final int landId;

  const LandDetailScreen({super.key, required this.landId});

  @override
  LandDetailScreenState createState() => LandDetailScreenState();
}

class LandDetailScreenState extends State<LandDetailScreen> {
  late Future<LandModel> _landDetailsFuture;

  @override
  void initState() {
    super.initState();
    _landDetailsFuture = LandProvider().getLandDetails(widget.landId); // Fetch land details by ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Land Details')),
      body: FutureBuilder<LandModel>(
        future: _landDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Land details not found.'));
          }

          final land = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  land.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Location: ${land.location}'),
                Text('Size: ${land.size} sqm'),
                Text('Price per Unit: \$${land.pricePerUnit}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/purchase',
                      arguments: land.id,
                    );
                  },
                  child: const Text('Purchase Units'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
