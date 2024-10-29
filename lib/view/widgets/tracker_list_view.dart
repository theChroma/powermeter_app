import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/controller/trackers_controller.dart';
import 'package:powermeter_app/view/widgets/selectable_builder.dart';
import 'package:powermeter_app/view/widgets/tracker_card.dart';

class TrackerListView extends StatelessWidget {
  final TrackersController trackersController;
  final SelectionController<String> selectionController;

  const TrackerListView({
    required this.trackersController,
    required this.selectionController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => trackersController.fetch(),
      child: ListenableBuilder(
        listenable: trackersController,
        builder: (context, child) {
          final trackers = trackersController.trackers;
          if (trackers == null) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: trackers.entries.map((tracker) {
              return SelectableBuilder(
                id: tracker.key,
                controller: selectionController,
                builder: (context, isSelected) {
                  return TrackerCard(
                    tracker: tracker.value,
                    isSelected: isSelected,
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}