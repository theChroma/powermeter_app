import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/view/pages/page_names.dart' as page_names;
import 'package:powermeter_app/view/widgets/device_list_view.dart';
import 'package:powermeter_app/view/widgets/error_builder.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectionController = SelectionController<int>();

    return ErrorBuilder(
      child: Scaffold(
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
                    leading: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => selectionController.deselectAll(),
                    ),
                    title: Text('${selectionController.selectionsCount} selected'),
                    actions: [
                      if (selectionController.selectionsCount == 1)  IconButton(
                        onPressed: () => debugPrint('edit clicked'),
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
                title: Text(page_names.devices),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_rounded),
          onPressed: () {
            context.pushNamed(page_names.addDevice);
          },
        ),
        body: Center(
          child: SizedBox(
            width: 1000,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: DeviceListView(
                deviceController: GetIt.I<DeviceController>(),
                selcetionController: selectionController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}