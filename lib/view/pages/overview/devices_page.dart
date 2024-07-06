import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/view/pages/wizard/add_device_page.dart';
import 'package:powermeter_app/view/widgets/device_list_view.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectionController = SelectionController<int>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: ListenableBuilder(
          listenable: selectionController,
          builder: (context, child) {
            if (selectionController.hasSelection) {
              return PopScope(
                canPop: false,
                onPopInvoked: (didPop) => selectionController.deselectAll(),
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
                        await GetIt.I<DeviceController>().remove(selectionController.selections.toList());
                        selectionController.deselectAll();
                      },
                    ),
                  ].map((child) => Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: child,)).toList(),
                ),
              );
            }
            return AppBar(
              elevation: 1,
              title: Text('Devices'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddDevicePage()));
        },
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: DeviceListView(
              deviceController: GetIt.I<DeviceController>(),
              selcetionController: selectionController,
            ),
          ),
        ),
      ),
    );
  }
}