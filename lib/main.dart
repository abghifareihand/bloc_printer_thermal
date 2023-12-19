import 'package:bloc_printer_thermal/bloc/bluetooth_printer_bloc.dart';
import 'package:bloc_printer_thermal/pages/home_page.dart';
import 'package:bloc_printer_thermal/pages/print_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BluetoothPrinterBloc()..add(GetDeviceEvent()),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
