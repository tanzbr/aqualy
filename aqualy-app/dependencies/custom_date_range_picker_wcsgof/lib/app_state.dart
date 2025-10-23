import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _startDate = '';
  String get startDate => _startDate;
  set startDate(String value) {
    _startDate = value;
  }

  String _endDate = '';
  String get endDate => _endDate;
  set endDate(String value) {
    _endDate = value;
  }
}
