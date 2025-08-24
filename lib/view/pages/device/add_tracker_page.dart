import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/trackers_controller.dart';
import 'package:powermeter_app/model/tracker_config.dart';

class AddTrackerPage extends StatelessWidget {
  final String? trackerId;

  AddTrackerPage({
    this.trackerId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final trackersController = GetIt.I<TrackersController>();
    final isEditing = trackerId != null;
    final tracker = isEditing ? (trackersController.trackers?[trackerId!]) : null;

    const scales = {
      'Seconds': Duration(seconds: 1),
      'Minutes': Duration(minutes: 1),
      'Hours': Duration(hours: 1),
      'Days': Duration(days: 1),
      'Weeks': Duration(days: 7),
      'Months': Duration(days: 30),
      'Years': Duration(days: 365),
    };


    final duration = isEditing ? _SplitDuration.split(
      duration: tracker!.duration,
      scales: scales.values
    ) : null;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(isEditing ? 'Edit Tracker' : 'Add Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Center(
          child: SizedBox(
            width: 500,
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    autofocus: true,
                    initialValue: tracker?.title,
                    name: 'title',
                    decoration: InputDecoration(label: Text('Title')),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'sampleCount',
                    initialValue: tracker?.sampleCount.toString(),
                    decoration: InputDecoration(label: Text('Sample Count')),
                    keyboardType: TextInputType.number,
                    valueTransformer: (value) => int.parse(value!),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer(),
                    ]),

                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: FormBuilderTextField(
                          name: 'duration.value',
                          initialValue: duration?.value.toString(),
                          decoration: InputDecoration(label: Text('Duration')),
                          keyboardType: TextInputType.number,
                          valueTransformer: (value) => int.parse(value!),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.integer(),
                          ]),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FormBuilderDropdown<Duration>(
                          name: 'duration.scale',
                          initialValue: duration?.scale,
                          decoration: InputDecoration(label: Text('')),
                          items: scales.entries.map(
                            (entry) => DropdownMenuItem<Duration>(
                              value: entry.value,
                              child: Text(entry.key),
                            ),
                          ).toList(),
                          validator: FormBuilderValidators.required(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_rounded),
        onPressed: () async {
          if (formKey.currentState == null) return;
          if (formKey.currentState!.saveAndValidate()) {
            final formValue = Map<String, dynamic>.from(formKey.currentState!.value);
            formValue['duration_s'] = _SplitDuration(
              value: formValue['duration.value'] as int,
              scale: formValue['duration.scale'] as Duration
            ).merged.inSeconds;
            final newTrackerConfig = TrackerConfig.fromJson(formValue);
            if (isEditing) {
              trackersController.update(trackerId!, newTrackerConfig);
            }
            else {
              trackersController.add(newTrackerConfig);
            }
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class _SplitDuration {
  final int value;
  final Duration scale;

  _SplitDuration({
    required this.value,
    required this.scale,
  });

  factory _SplitDuration.split({
    required Duration duration,
    required Iterable<Duration> scales,
  }) {
    final sortedScales = List<Duration>.from(scales);
    sortedScales.sort((a, b) => b.compareTo(a));

    for (final scale in sortedScales) {
      if (duration.inSeconds % scale.inSeconds == 0) {
        return _SplitDuration(
          value:  duration.inSeconds ~/ scale.inSeconds,
          scale: scale
        );
      }
    }
    return _SplitDuration(
      value: duration.inSeconds,
      scale: Duration(seconds: 1)
    );
  }

  Duration get merged => Duration(seconds: value * scale.inSeconds);
}
