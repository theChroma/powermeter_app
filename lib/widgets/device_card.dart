import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powermeter_app/modules/device.dart';
import 'package:powermeter_app/widgets/power_switch.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class DeviceCard extends StatefulWidget {
  final Device device;
  const DeviceCard({
    required this.device,
    super.key
  });

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  BehaviorSubject<double?>? _powerController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _powerController = BehaviorSubject.seeded(null);
    _fetchPower();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _fetchPower();
      }
    );
  }

  @override
  void dispose() {
    _powerController?.close();
    _timer?.cancel();
    super.dispose();
  }

  void _fetchPower() async {
    // try {
    //   final response = await http.get(Uri.http(widget.device.host, '/api/v0.0.0/measure')).timeout(Duration(seconds: 1));
    //   if (response.statusCode == 200) {
    //     final data = jsonDecode(response.body);
    //     // if (data['type'])
    //     // // _powerController?.add();
    //   }
    // } catch(error) {
    //   _powerController?.add(null);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: InkWell(
        onLongPress: () {
          debugPrint('Device Card long pressed');
        },
        onTap: () {
          debugPrint('Device Card tapped');
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.device.name,
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                    Text(widget.device.host),
                  ],
                ),
                StreamBuilder(
                  stream: null,
                  builder: (context, snapshot) {
                    return Text('${snapshot.data ?? '-'} W', style: TextStyle(fontSize: 30),);
                  },
                ),
                Builder(builder: (context) {
                  final powerSwitch = PowerSwitchController(host: widget.device.host);

                  return Column(children: [
                    PowerSwitch(model: powerSwitch),
                    ListenableBuilder(listenable: powerSwitch, builder: (context, child) => Text(powerSwitch.state.toString()),)
                  ],);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}