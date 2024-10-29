import 'dart:async';
import 'package:flutter/material.dart';
import 'package:powermeter_app/fetcher/trackers_config_fetcher.dart';
import 'package:powermeter_app/fetcher/trackers_fetcher.dart';
import 'package:powermeter_app/helpers/lifecycle_change_notifier.dart';
import 'package:powermeter_app/model/tracker.dart';

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
    final unsortedTrackers = await fetcher.getTrackers();
    trackers = Map.fromEntries(
      unsortedTrackers.entries
      .toList()
      ..sort(
        (a, b) => a.value.duration.compareTo(b.value.duration),
      )
    );
    notifyListeners();
  }
}