import 'package:bloc_printer_thermal/bloc/bluetooth_printer_bloc.dart';
import 'package:bloc_printer_thermal/pages/home_page.dart';
import 'package:bloc_printer_thermal/widgets/button.dart';
import 'package:bloc_printer_thermal/widgets/list_printer_widget.dart';
import 'package:bloc_printer_thermal/widgets/payment_success_dialog.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({super.key});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Print Page'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// State Printer Connected
          BlocBuilder<BluetoothPrinterBloc, BluetoothPrinterState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Klik disini -->',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// Connected
                    state is BluetoothPrinterConnected
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: Button.filled(
                              color: Colors.redAccent,
                              label: 'Belum Terhubung',
                              onPressed: () {
                                context
                                    .read<BluetoothPrinterBloc>()
                                    .add(GetDeviceEvent());

                                return showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocBuilder<BluetoothPrinterBloc,
                                        BluetoothPrinterState>(
                                      builder: (context, state) {
                                        if (state
                                            is BluetoothPrinterDeviceList) {
                                          final devices = state.devices;
                                          if (devices.isEmpty) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Tidak Ada Device Terdeteksi',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: const Text(
                                                'Hidupkan Bluetooth anda dan pastikan perangkat Bluetooth printer aktif.',
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                Button.filled(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  label: 'OK',
                                                ),
                                              ],
                                            );
                                          } else {
                                            return AlertDialog(
                                              title: const Text(
                                                'Pilih Device Printer',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: SizedBox(
                                                width: double.maxFinite,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: devices.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    debugPrint(
                                                        'Ada ${devices.length} device terbaca');
                                                    BluetoothDevice device =
                                                        state.devices[index];
                                                    return InkWell(
                                                      onTap: () async {
                                                        context
                                                            .read<
                                                                BluetoothPrinterBloc>()
                                                            .add(
                                                                ConnectDeviceEvent(
                                                                    device));

                                                        Navigator.pop(context);
                                                      },
                                                      child: ListPrinterWidget(
                                                          device: device),
                                                    );
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                Button.filled(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  label: 'Selesai',
                                                ),
                                              ],
                                            );
                                          }
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                    /// Disconnected
                    state is BluetoothPrinterConnected
                        ? Expanded(
                            child: Button.filled(
                              color: Colors.green,
                              label: 'Sudah Terhubung',
                              onPressed: () {
                                context
                                    .read<BluetoothPrinterBloc>()
                                    .add(DisconnectDeviceEvent());

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Printer diputuskan'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<BluetoothPrinterBloc, BluetoothPrinterState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Button.filled(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => PaymentSuccessDialog(
                    onSave: () {
                      debugPrint('Save');
                    },
                    onPrint: () async {
                      if (state is BluetoothPrinterConnected) {
                        debugPrint('State saat print $state');
                        BlueThermalPrinter bluetooth =
                            BlueThermalPrinter.instance;
                        if ((await bluetooth.isConnected)!) {
                          bluetooth.printNewLine();
                          bluetooth.printCustom('Test Print', 1, 1);
                        }
                      }
                    },
                  ),
                );
              },
              label: 'Submit',
            ),
          );
        },
      ),
    );
  }
}
