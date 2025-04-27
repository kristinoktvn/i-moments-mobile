import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime? selectedDate;
  String theme = 'Classic';

  Future<void> createEvent() async {
    final response = await http.post(
      Uri.parse('https://your-backend-url/api/events/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': 1, // ganti sesuai ID user setelah login
        'title': titleController.text,
        'description': descriptionController.text,
        'date_time': selectedDate!.toIso8601String(),
        'location': locationController.text,
        'theme': theme,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuat event')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul Acara'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi Acara'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Lokasi Acara'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: const Text('Pilih Tanggal Acara'),
            ),
            DropdownButton<String>(
              value: theme,
              items: ['Classic', 'Modern', 'Minimalist']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  theme = val!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createEvent,
              child: const Text('Simpan Event'),
            ),
          ],
        ),
      ),
    );
  }
}
