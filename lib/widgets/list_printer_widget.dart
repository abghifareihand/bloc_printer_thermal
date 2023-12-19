import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

class ListPrinterWidget extends StatelessWidget {
  final BluetoothDevice device;
  const ListPrinterWidget({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.print, color: Colors.blue),
        title: Text(device.name!),
        subtitle: Text(device.address!),
      ),
    );
  }
}
