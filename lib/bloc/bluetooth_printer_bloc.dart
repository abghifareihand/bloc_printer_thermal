import 'package:bloc_printer_thermal/models/print_model.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bluetooth_printer_event.dart';
part 'bluetooth_printer_state.dart';

class BluetoothPrinterBloc
    extends Bloc<BluetoothPrinterEvent, BluetoothPrinterState> {
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BluetoothPrinterBloc() : super(BluetoothPrinterInitial()) {
    on<GetDeviceEvent>((event, emit) async {
      emit(BluetoothPrinterLoading());
      try {
        final devices = await bluetooth.getBondedDevices();
        emit(BluetoothPrinterDeviceList(devices));
      } catch (e) {
        emit(BluetoothPrinterError(e.toString()));
      }
    });

    on<ConnectDeviceEvent>((event, emit) async {
      emit(BluetoothPrinterLoading());
      try {
        await bluetooth.connect(event.device);
        emit(BluetoothPrinterConnected(event.device));
        debugPrint('Bluetooth printer connected to ${event.device.address}');
      } catch (e) {
        emit(BluetoothPrinterError(e.toString()));
      }
    });

    on<DisconnectDeviceEvent>((event, emit) async {
      emit(BluetoothPrinterLoading());
      try {
        await bluetooth.disconnect();
        emit(BluetoothPrinterDisconnected());
      } catch (e) {
        emit(BluetoothPrinterError(e.toString()));
      }
    });

    on<ActiveDeviceEvent>((event, emit) async {
      emit(BluetoothPrinterLoading());
      try {
        bool? isConnected = await bluetooth.isConnected;
        emit(BluetoothDeviceActive(isConnected));
      } catch (e) {
        emit(BluetoothDeviceActiveError(e.toString()));
      }
    });

    on<PrintTextEvent>((event, emit) async {
      emit(BluetoothPrinterLoading());
      try {
        bool? isConnected = await bluetooth.isConnected;
        if (isConnected!) {
          bluetooth.printNewLine();
          bluetooth.printCustom(event.printModel.judul, 3, 1);
          bluetooth.printNewLine();
          bluetooth.printLeftRight('Nama', event.printModel.name, 1);
          bluetooth.printLeftRight(
              'Deskripsi', event.printModel.description, 1);
          bluetooth.printLeftRight('Harga', event.printModel.price, 1);
          bluetooth.printNewLine();
          bluetooth.printCustom(event.printModel.date, 1, 1);
          bluetooth.printNewLine();
        } else {
          debugPrint('Bloc Bluetooth printer is not connected');
        }
      } catch (e) {
        emit(BluetoothPrinterError(e.toString()));
      }
    });
  }
}
