import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/devices_controller.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/view/widgets/device_card.dart';
import 'package:powermeter_app/view/widgets/selectable_builder.dart';

class DeviceListView extends StatelessWidget {
  final DevicesController devicesController;
  final SelectionController<int> selcetionController;

  const DeviceListView({
    required this.devicesController,
    required this.selcetionController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: devicesController,
      builder: (context, child) {
        return ReorderableListView(
          buildDefaultDragHandles: false,
          children: devicesController.devices.indexed.map((deviceAt) {
            final index = deviceAt.$1;
            final device = deviceAt.$2;
            return SelectableBuilder(
              key: ValueKey(index),
              id: index,
              controller: selcetionController,
              builder: (context, isSelected) {
                return ReorderableDragStartListener(
                  index: index,
                  enabled: isSelected,
                  child: DeviceCard(
                    device: device,
                    isSelected: isSelected,
                    isSelectionMode: selcetionController.hasSelection,
                  ),
                );
              }
            );
          }).toList(),
          onReorder: (oldIndex, newIndex) {
            reorderSelections(oldIndex, newIndex);
            devicesController.reorder(oldIndex, newIndex);
        });
      },
    );
  }

  void reorderSelections(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    if (!selcetionController.isSelected(newIndex)) {
      selcetionController.deselect(oldIndex);
    }
    selcetionController.select(newIndex);
  }
}
