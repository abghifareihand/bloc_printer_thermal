part of 'bluetooth_printer_bloc.dart';

abstract class BluetoothPrinterState {}

final class BluetoothPrinterInitial extends BluetoothPrinterState {}

final class BluetoothPrinterLoading extends BluetoothPrinterState {}

final class BluetoothPrinterError extends BluetoothPrinterState {
  final String message;
  BluetoothPrinterError(this.message);
}

final class BluetoothPrinterDeviceList extends BluetoothPrinterState {
  final List<BluetoothDevice> devices;
  BluetoothPrinterDeviceList(this.devices);
}

final class BluetoothPrinterConnected extends BluetoothPrinterState {
  final BluetoothDevice printer;
  BluetoothPrinterConnected(this.printer);
}

final class BluetoothPrinterDisconnected extends BluetoothPrinterState {}

final class BluetoothDeviceActive extends BluetoothPrinterState {
  final bool? isConnected;
  BluetoothDeviceActive(this.isConnected);
}
final class BluetoothDeviceActiveError extends BluetoothPrinterState {
  final String message;

  BluetoothDeviceActiveError(this.message);

}

final class BluetoothPrinterPrinted extends BluetoothPrinterState {}
