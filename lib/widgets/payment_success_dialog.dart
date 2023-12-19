import 'package:bloc_printer_thermal/bloc/bluetooth_printer_bloc.dart';
import 'package:bloc_printer_thermal/constant/app_color.dart';
import 'package:bloc_printer_thermal/constant/spaces.dart';
import 'package:bloc_printer_thermal/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final Function() onSave;
  final Function() onPrint;

  const PaymentSuccessDialog({
    super.key,
    required this.onSave,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Icon(Icons.check_circle, size: 80, color: Colors.green)),
          SpaceHeight(12.0),
          Text(
            'Pembayaran telah sukses dilakukan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _LabelValue(
            label: 'TANGGAL',
            value: '01-04-2001',
          ),
          const Divider(height: 36.0),
          const _LabelValue(
            label: 'NAMA',
            value: 'Abghi Fareihan',
          ),
          const Divider(height: 36.0),
          const _LabelValue(
            label: 'DESKRIPSI',
            value: 'Ini adalah deskripsi',
          ),
          const Divider(height: 36.0),
          const _LabelValue(
            label: 'TOTAL PEMBELIAN',
            value: 'Rp. 150.000.000',
          ),
          const SpaceHeight(40.0),
          BlocBuilder<BluetoothPrinterBloc, BluetoothPrinterState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Menampilkan tombol "Print" jika printer terhubung
                  if (state is BluetoothPrinterConnected)
                    Flexible(
                      child: Button.outlined(
                        onPressed: () {
                          onPrint();
                          Navigator.pop(context);
                        },
                        label: 'Print',
                        icon: const Icon(
                          Icons.print,
                          size: 18,
                          color: Colors.blue,
                        ),
                        fontSize: 14,
                      ),
                    ),
                  // Menampilkan tombol "Simpan" jika printer tidak terhubung
                  if (state is BluetoothPrinterDisconnected)
                    Flexible(
                      child: Button.filled(
                        onPressed: () {
                          onSave();
                          Navigator.pop(context);
                        },
                        label: 'Simpan',
                        icon: const Icon(
                          Icons.save,
                          size: 18,
                          color: Colors.white,
                        ),
                        fontSize: 14,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(),
        ),
        const SpaceHeight(5.0),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
