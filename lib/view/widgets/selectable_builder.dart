import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/selection_controller.dart';

typedef SelectableBuilderFunction<T> = Widget Function(
  BuildContext context,
  bool isSelected,
);

class SelectableBuilder<T> extends StatelessWidget {
  const SelectableBuilder({
    required this.id,
    required this.builder,
    required this.controller,
    super.key,
  });

  final T id;
  final SelectableBuilderFunction<T> builder;
  final SelectionController<T> controller;

  void toggleSelected() {
    if (controller.isSelected(id)) {
      controller.deselect(id);
    }
    else {
      controller.select(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return GestureDetector(
           onLongPress: toggleSelected,
          onSecondaryTap: toggleSelected,
          onTap: controller.hasSelection ? toggleSelected : null,
          child: builder(context, controller.isSelected(id))
        );
      }
    );
  }
}