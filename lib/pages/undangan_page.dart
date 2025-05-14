import 'package:flutter/material.dart';

class UndanganPage extends StatefulWidget {
  const UndanganPage({super.key});

  @override
  State<UndanganPage> createState() => _UndanganPageState();
}

class _UndanganPageState extends State<UndanganPage> {
  List<Map<String, String>> events = [
    {'title': 'Ulang Tahun Andi', 'date_time': '2025-05-20', 'category': 'Ulang Tahun'},
    {'title': 'Rapat Proyek A', 'date_time': '2025-05-21', 'category': 'Meeting'},
    {'title': 'Acara Pernikahan Budi', 'date_time': '2025-05-25', 'category': 'Pernikahan'},
  ];

  final List<String> categories = ['Pernikahan', 'Ulang Tahun', 'Engagement', 'Meeting'];

  void deleteEvent(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Konfirmasi'),
        content: const Text('Yakin ingin menghapus event ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                events.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void openEventDialog({Map<String, String>? existingEvent, int? index}) {
    String title = existingEvent?['title'] ?? '';
    String category = existingEvent?['category'] ?? categories.first;
    DateTime? selectedDate = existingEvent != null
        ? DateTime.tryParse(existingEvent['date_time']!)
        : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(builder: (context, setModalState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    existingEvent != null ? 'Edit Event' : 'Buat Event Baru',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Judul Acara',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: title),
                    onChanged: (val) => title = val,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: category,
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                    items: categories.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                    onChanged: (val) {
                      setModalState(() {
                        category = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.deepPurple,
                    ),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Pilih Tanggal Acara'),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setModalState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  if (selectedDate != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Tanggal: ${selectedDate!.toLocal()}'.split(' ')[0],
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if (title.isEmpty || selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Harap isi judul dan tanggal')),
                        );
                        return;
                      }

                      setState(() {
                        if (existingEvent != null && index != null) {
                          events[index] = {
                            'title': title,
                            'date_time': '${selectedDate!.toLocal()}'.split(' ')[0],
                            'category': category,
                          };
                        } else {
                          events.add({
                            'title': title,
                            'date_time': '${selectedDate!.toLocal()}'.split(' ')[0],
                            'category': category,
                          });
                        }
                      });

                      Navigator.pop(context);
                    },
                    child: Text(existingEvent != null ? 'Update' : 'Simpan'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undanganmu'),
        backgroundColor: Colors.deepPurple,
      ),
      body: events.isEmpty
          ? const Center(child: Text('Belum ada event'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        event['title']![0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      event['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${event['date_time']} | ${event['category']}'),
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => openEventDialog(existingEvent: event, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteEvent(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openEventDialog(),
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Event'),
      ),
    );
  }
}
