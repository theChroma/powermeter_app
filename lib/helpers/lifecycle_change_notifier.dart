import 'package:flutter/material.dart';

abstract class LifecyleChangeNotifier with ChangeNotifier {
  @override
  void addListener(VoidCallback listener) {
    if (!hasListeners) {
      addFirstListener(listener);
    }
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      removeLastListener(listener);
    }
  }

  @override
  void notifyListeners() {
    if (hasListeners) {
      super.notifyListeners();
    }
  }

  void addFirstListener(VoidCallback listener) {}
  void removeLastListener(VoidCallback listener) {}
}