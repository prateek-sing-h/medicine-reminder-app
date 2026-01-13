import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MedicineTile extends StatelessWidget {
  final Medicine medicine;

  const MedicineTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final time =
        TimeOfDay.fromDateTime(medicine.time).format(context);

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading:
            const Icon(Icons.medication, color: Colors.teal),
        title: Text(medicine.name),
        subtitle: Text('${medicine.dose} • $time'),
      ),
    );
  }
}
