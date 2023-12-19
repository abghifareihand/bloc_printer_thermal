// ElevatedButton(
//                       onPressed: () {
//                         if (state is BluetoothPrinterConnected) {
//                           debugPrint('State saat print $state');
//                           final model = PrintModel(
//                             judul: 'TEST PRINT',
//                             name: 'Ngeprint Nih',
//                             description: 'Deskripsi Nih',
//                             price: 'Rp. 10.000',
//                             date: DateFormat('dd MMMM yyyy HH:mm:ss')
//                                 .format(DateTime.now())
//                                 .toString(),
//                           );
//                           debugPrint(model.toString());
//                           context
//                               .read<BluetoothPrinterBloc>()
//                               .add(PrintTextEvent(printModel: model));
//                         } else {
//                           debugPrint('State saat print $state');
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('Printer not connected'),
//                             ),
//                           );
//                         }
//                       },
//                       child: const Text("Print Page"),
//                     ),