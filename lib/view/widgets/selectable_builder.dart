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
    required this.selectionController,
    super.key,
  });

  final T id;
  final SelectableBuilderFunction<T> builder;
  final SelectionController<T> selectionController;

  void toggleSelected() {
    if (selectionController.isSelected(id)) {
      selectionController.deselect(id);
    }
    else {
      selectionController.select(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: selectionController,
      builder: (context, child) {
        return GestureDetector(
           onLongPress: toggleSelected,
          onSecondaryTap: toggleSelected,
          onTap: selectionController.hasSelection ? toggleSelected : null,
          child: builder(context, selectionController.isSelected(id))
        );
      }
    );
  }
}