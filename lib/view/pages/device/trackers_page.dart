import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/controller/trackers_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/pages/device/add_tracker_page.dart';
import 'package:powermeter_app/view/widgets/app_bar_listenable_builder.dart';
import 'package:powermeter_app/view/widgets/tracker_list_view.dart';

class TrackersPage extends StatelessWidget {
  final Device device;

  const TrackersPage({
    required this.device,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final trackersController = GetIt.I<TrackersController>();
    final selectionController = SelectionController<String>();

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
                      await Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddTrackerPage(trackerId: selectionController.selections.first)
                      ));
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
                              onPressed: () {
                                trackersController.delete(selectionController.selections).then(
                                  (_) => selectionController.deselectAll()
                                );
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                      selectionController.deselectAll();
                    },
                  ),
                ].map((child) => Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: child,)).toList(),
              ),
            );
          }
          return AppBar(
            leading: BackButton(onPressed: () {
              Navigator.pop(context);
            }),
            title: Text('Trackers'),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: TrackerListView(
            trackersController: trackersController,
            selectionController: selectionController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTrackerPage()));
        },
      ),
    );
  }
}
