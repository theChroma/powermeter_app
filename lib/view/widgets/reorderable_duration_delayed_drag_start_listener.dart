import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class ReorderableDurationDelayedDragStartListener extends ReorderableDragStartListener {
  final Duration delay;

  const ReorderableDurationDelayedDragStartListener({
    this.delay = kLongPressTimeout,
    required super.index,
    required super.child,
    super.key,
    super.enabled = true,
  });

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(delay: delay, debugOwner: this);
  }
}