import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_provider.dart';
import '../widgets/medicine_tile.dart';
import 'add_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Reminder')),
      body: provider.medicines.isEmpty
          ? const Center(
              child: Text(
                'No medicines added yet',
                style: TextStyle(color: Colors.teal),
              ),
            )
          : ListView.builder(
              itemCount: provider.medicines.length,
              itemBuilder: (_, i) =>
                  MedicineTile(medicine: provider.medicines[i]),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMedicineScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
