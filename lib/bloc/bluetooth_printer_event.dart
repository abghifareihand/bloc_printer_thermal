part of 'bluetooth_printer_bloc.dart';

abstract class BluetoothPrinterEvent {}

final class GetDeviceEvent extends BluetoothPrinterEvent {}

final class ConnectDeviceEvent extends BluetoothPrinterEvent {
  final BluetoothDevice device;
  ConnectDeviceEvent(this.device);
}

final class DisconnectDeviceEvent extends BluetoothPrinterEvent {}

final class ActiveDeviceEvent extends BluetoothPrinterEvent {
  final BluetoothDevice device;
  ActiveDeviceEvent(this.device);
}

final class PrintTextEvent extends BluetoothPrinterEvent {
  final PrintModel printModel;
  PrintTextEvent(this.printModel);
}
