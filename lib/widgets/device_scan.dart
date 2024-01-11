import 'package:flutter/material.dart';
import 'package:multicast_dns/multicast_dns.dart';

Future<List<String>> scanDevices(String servicName) async {
  final client = MDnsClient();
  await client.start();
  List<String> devices = [];
  await for (final ptr in client.lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(servicName))) {
    // Use the domainName from the PTR record to get the SRV record,
    // which will have the port and local hostname.
    // Note that duplicate messages may come through, especially if any
    // other mDNS queries are running elsewhere on the machine.
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
      final String bundleId =
          ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
      devices.add('${srv.target}:${srv.port} for "$bundleId".');
      print('${srv.target}:${srv.port} for "$bundleId".');
    }
  }
  return devices;
}

class DeviceScan extends StatelessWidget {
   
  DeviceScan({super.key});

  @override
  Widget build(BuildContext context) {
    scanDevices('_http._tcp');
    return Placeholder();
    // return FutureBuilder(
    //   future: ,
    //   builder: (context, snapshot) {
    //     return 
    //   },
    // );
  }
}