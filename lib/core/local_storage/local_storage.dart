library local_storage;

import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path;
part 'hive_box.dart';
part 'hive_keys.dart';

@LazySingleton()
class LocalStorage {
  // Initialize Hive
  Future<void> initHive() async {
    String? directoryPath;

    if (Platform.isIOS) {
      final directory = await path.getApplicationSupportDirectory();
      directoryPath = directory.path;
    }

    await Hive.initFlutter(directoryPath);
  }

  // Open a box
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  /// Close the box
  Future<void> closeBox<T>(String boxName) async {
    final box = await _getBoxByName(boxName);
    await box.close();
  }

  // Write data to a box
  Future<void> addData<T>({
    required String boxName,
    required T value,
  }) async {
    final box = await _getBoxByName<T>(boxName);
    await box.add(value);
  }

  // Write data to a box
  Future<void> putData<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = await _getBoxByName<T>(boxName);
    await box.put(key, value);
  }

  // Read data from a box
  Future<T?> readData<T>({
    required String boxName,
    required String key,
  }) async {
    final box = await _getBoxByName<T>(boxName);
    final data = box.get(key);
    return data;
  }

  // Read data from a box
  Future<List<T>> readAllData<T>({
    required String boxName,
  }) async {
    final box = await _getBoxByName<T>(boxName);
    final data = box.values.toList();
    return data;
  }

  // Delete data from a box
  Future<void> deleteData<T>({
    required String boxName,
    String? key,
  }) async {
    final box = await _getBoxByName<T>(boxName);
    if (key != null) {
      await box.delete(key);
    } else {
      await box.clear();
    }
  }

  /// get box by name
  Future<Box<T>> _getBoxByName<T>(String boxName) async {
    switch (boxName) {
      case HiveBox.expense:
        final expenseBoc = await openBox<T>(boxName);
        return expenseBoc;
      default:
        final commonBox = await openBox<T>(HiveBox.commonBox);
        return commonBox;
    }
  }
}
