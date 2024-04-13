import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/view/widgets/device_card.dart';
import 'package:powermeter_app/view/widgets/selectable_builder.dart';

class DeviceListView extends StatelessWidget {
  final DeviceController deviceController;
  final SelectionController<int> selcetionController;

  const DeviceListView({
    required this.deviceController,
    required this.selcetionController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: deviceController,
      builder: (context, child) {
        return ReorderableListView(
          buildDefaultDragHandles: false,
          children: deviceController.devices.indexed.map((deviceAt) {
            final index = deviceAt.$1;
            final device = deviceAt.$2;
            return ReorderableDragStartListener(
              key: ValueKey(index),
              index: index,
              child: SelectableBuilder(
                id: index,
                selectionController: selcetionController,
                builder: (context, isSelected) {
                  return DeviceCard(
                    device: device,
                    isSelected: isSelected,
                    isSelectionMode: selcetionController.hasSelection,
                  );
                }
              )
            );
          }).toList(),
          onReorder: (oldIndex, newIndex) {
            deviceController.reorder(oldIndex, newIndex);
        });
      },
    );
  }
}