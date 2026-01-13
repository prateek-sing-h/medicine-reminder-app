import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine_model.dart';
import '../providers/medicine_provider.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController doseCtrl = TextEditingController();
  TimeOfDay? time;

  void saveMedicine() {
    if (nameCtrl.text.isEmpty ||
        doseCtrl.text.isEmpty ||
        time == null) {
      return;
    }

    final now = DateTime.now();
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time!.hour,
      time!.minute,
    );

    if (dateTime.isBefore(now)) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    Provider.of<MedicineProvider>(context, listen: false)
        .addMedicine(
      Medicine(
        name: nameCtrl.text,
        dose: doseCtrl.text,
        time: dateTime,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medicine')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration:
                  const InputDecoration(labelText: 'Medicine Name'),
            ),
            TextField(
              controller: doseCtrl,
              decoration:
                  const InputDecoration(labelText: 'Dose'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {});
              },
              child: Text(
                time == null
                    ? 'Pick Time'
                    : time!.format(context),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: saveMedicine,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
