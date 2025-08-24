import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/devices_controller.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/view/pages/wizard/add_device_page.dart';
import 'package:powermeter_app/view/widgets/app_bar_listenable_builder.dart';
import 'package:powermeter_app/view/widgets/device_list_view.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectionController = SelectionController<int>();

    return Scaffold(
      appBar: AppBarListenableBuilder(
        listenable: selectionController,
        builder: (context, child) {
          if (selectionController.hasSelection) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) => selectionController.deselectAll(),
              child: AppBar(
                leading: CloseButton(
                  onPressed: () => selectionController.deselectAll(),
                ),
                title: Text('${selectionController.selectionsCount} selected'),
                actions: [
                  if (selectionController.selectionsCount == 1) IconButton(
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AddDevicePage(deviceIndex: selectionController.selections.first);
                      }));
                      selectionController.deselectAll();
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Are you sure you want to delete all selected Devices?'),
                          actions: [
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () async {
                                await GetIt.I<DevicesController>().remove(selectionController.selections.toList());
                                selectionController.deselectAll();
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ].map((child) => Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: child,
                )).toList(),
              ),
            );
          }
          return AppBar(
            elevation: 1,
            title: Text('Devices'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddDevicePage()));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: SizedBox(
            width: 1000,
            child: DeviceListView(
              devicesController: GetIt.I<DevicesController>(),
              selcetionController: selectionController,
            ),
          ),
        ),
      ),
    );
  }
}