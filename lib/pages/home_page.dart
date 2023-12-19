import 'package:bloc_printer_thermal/pages/print_page.dart';
import 'package:bloc_printer_thermal/pages/report_page.dart';
import 'package:bloc_printer_thermal/widgets/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const PrintPage();
                    },
                  ),
                );
              },
              label: 'Print Page',
            ),
            const SizedBox(height: 12.0),
            Button.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ReportPage();
                    },
                  ),
                );
              },
              label: 'Report Page',
            ),
          ],
        ),
      ),
    );
  }
}
