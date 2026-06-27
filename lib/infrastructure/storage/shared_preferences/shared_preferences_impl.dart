import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [StorageInterface] using the shared_preferences package.
class SharedPreferencesImpl implements StorageInterface {
  /// Creates an instance of [SharedPreferencesImpl] with the provided
  /// [SharedPreferences] instance.
  SharedPreferencesImpl(this._prefs);
  final SharedPreferences _prefs;

  /// Factory method to create an instance of [SharedPreferencesImpl] by
  /// initializing the underlying [SharedPreferences] instance.
  static Future<SharedPreferencesImpl> create() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return SharedPreferencesImpl(prefs);
  }

  @override
  Future<void> setDouble({required String key, required double value}) async {
    try {
      await _prefs.setDouble(key, value);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  double? getDouble({required String key}) {
    try {
      return _prefs.getDouble(key);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    try {
      await _prefs.setString(key, value);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    try {
      await _prefs.setBool(key, value);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  String? getString({required String key}) {
    try {
      return _prefs.getString(key);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  bool? getBool({required String key}) {
    try {
      return _prefs.getBool(key);
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  List<String> getList({required String key}) {
    try {
      return _prefs.getStringList(key) ?? <String>[];
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<List<String>> addToList({
    required String key,
    required String value,
  }) async {
    try {
      final List<String> list = List<String>.from(
        _prefs.getStringList(key) ?? <String>[],
      );
      if (!list.contains(value)) {
        list.add(value);
        await _prefs.setStringList(key, list);
      }
      return list;
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<List<String>> removeFromList({
    required String key,
    required String value,
  }) async {
    try {
      final List<String> list = List<String>.from(
        _prefs.getStringList(key) ?? <String>[],
      )..remove(value);
      await _prefs.setStringList(key, list);
      return list;
    } on Object catch (e, st) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }
}
