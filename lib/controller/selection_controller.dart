import 'package:flutter/material.dart';

class SelectionController<T> extends ChangeNotifier {
  final Set<T> selections = {};

  bool get hasSelection => selections.isNotEmpty;
  int get selectionsCount => selections.length;

  bool isSelected(T id) => selections.contains(id);

  void select(T id) {
    selections.add(id);
    notifyListeners();
  }

  void deselect(T id) {
    selections.remove(id);
    notifyListeners();
  }

  void deselectAll() {
    selections.clear();
    notifyListeners();
  }
}