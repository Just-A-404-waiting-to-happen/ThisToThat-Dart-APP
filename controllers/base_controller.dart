// lib/controllers/base_converter_controller.dart

import 'package:flutter/material.dart';
import 'package:myapp/models/base_manager.dart';

class BaseConverterController extends ChangeNotifier {
  final BaseConverterModel _model;

  BaseConverterController() : _model = BaseConverterModel();

  String get inputNumber => _model.inputNumber;
  int get currentBase => _model.currentBase;
  int get targetBase => _model.targetBase;
  String? get result => _model.result;
  String? get error => _model.error;

  void setInputNumber(String value) {
    _model.inputNumber = value;
    _convert();
  }

  void setCurrentBase(int base) {
    _model.currentBase = base;
    _convert();
  }

  void setTargetBase(int base) {
    _model.targetBase = base;
    _convert();
  }

  void _convert() {
    try {
      _model.error = null;
      if (_model.inputNumber.isNotEmpty) {
        _model.result = _model.convert();
      } else {
        _model.result = null;
      }
    } catch (e) {
      _model.error = e.toString();
      _model.result = null;
    }
    notifyListeners();
  }

  void swapBases() {
    final temp = _model.currentBase;
    _model.currentBase = _model.targetBase;
    _model.targetBase = temp;
    if (_model.result != null) {
      _model.inputNumber = _model.result!;
      _convert();
    }
    notifyListeners();
  }

  List<int> get supportedBases => BaseConverterModel.supportedBases;

  String getValidDigitsForBase(int base) =>
      BaseConverterModel.getValidDigitsForBase(base);
}
