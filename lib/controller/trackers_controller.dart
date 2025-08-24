import 'dart:async';
import 'package:flutter/material.dart';
import 'package:powermeter_app/fetcher/trackers_config_fetcher.dart';
import 'package:powermeter_app/fetcher/trackers_fetcher.dart';
import 'package:powermeter_app/helpers/lifecycle_change_notifier.dart';
import 'package:powermeter_app/model/tracker.dart';
import 'package:powermeter_app/model/tracker_config.dart';
import 'package:powermeter_app/model/trackers_config.dart';

class TrackersController extends LifecyleChangeNotifier {
  Timer? _timer;
  Map<String, Tracker>? trackers;
  final TrackersFetcher fetcher;
  final TrackersConfigFetcher configFetcher;

  TrackersController({
    required this.fetcher,
    required this.configFetcher,
  });

  @override
  void addFirstListener(VoidCallback listener) {
    fetch();
    _timer = Timer.periodic(Duration(seconds: 60), (timer) => fetch());
  }

  @override
  void removeLastListener(VoidCallback listener) {
    _timer?.cancel();
  }

  Future<void> fetch() async {
    final unsortedTrackers = await fetcher.get();
    trackers = Map.fromEntries(
      unsortedTrackers.entries
      .toList()
      ..sort(
        (a, b) => a.value.duration.compareTo(b.value.duration),
      )
    );
    notifyListeners();
  }

  Future<void> add(TrackerConfig newTrackerConfig) async {
    trackers = null;
    notifyListeners();
    await configFetcher.add(newTrackerConfig);
    await fetch();
  }

  Future<void> update(String id, TrackerConfig newTrackerConfig) async {
    trackers = null;
    notifyListeners();
    await configFetcher.update(TrackersConfig(trackers: {id: newTrackerConfig}));
    await fetch();
  }

  Future<void> delete(Set<String> ids) async {
    trackers = null;
    notifyListeners();
    await configFetcher.delete(ids);
    await fetch();
  }
}