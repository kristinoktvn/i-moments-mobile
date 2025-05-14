// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   List events = [];

//   Future<void> fetchEvents() async {
//     final response = await http.get(Uri.parse('https://your-backend-url/api/events'));

//     if (response.statusCode == 200) {
//       setState(() {
//         events = json.decode(response.body);
//       });
//     } else {
//       print('Gagal mengambil data event');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchEvents();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Undanganmu')),
//       body: ListView.builder(
//         itemCount: events.length,
//         itemBuilder: (context, index) {
//           final event = events[index];
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: ListTile(
//               title: Text(event['title']),
//               subtitle: Text(event['date_time']),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/edit-event', arguments: event);
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       // delete event (optional buat)
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/create-event');
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data dummy category counts
    final datas = {'Pernikahan': 3, 'Ulang Tahun': 2, 'Engagement': 5};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: PieChart(
            PieChartData(
              sections: datas.entries.map((e) {
                return PieChartSectionData(
                  value: e.value.toDouble(),
                  title: e.key,
                  color: Colors.primaries[datas.keys.toList().indexOf(e.key) % Colors.primaries.length],
                );
              }).toList(),
              sectionsSpace: 2,
              centerSpaceRadius: 50,
            ),
          ),
        ),
      ),
    );
  }
}
