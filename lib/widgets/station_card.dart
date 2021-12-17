import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/station_model.dart';

class StationCard extends StatelessWidget {
  const StationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final station = context.watch<StationModel>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: _signalIconFromStrength(station.signalStrength),
        title: Text(
            '${station.callSign}: ${station.frequency} ${station.protocol}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Format: ${station.format}'),
            Text('Distance: ${_distanceFormat(station.distance)}')
          ],
        ),
        trailing: IconButton(icon: const Icon(Icons.map), onPressed: () {}),
      ),
    );
  }

  Icon _signalIconFromStrength(double signalStrength) {
    if (signalStrength < 0.25) {
      return const Icon(Icons.signal_wifi_0_bar);
    } /* else if (signalStrength < 0.25) {
      return const Icon(Icons.signal_wifi_1_bar)
    } else if (signalStrength < 0.25) {
      return const Icon(Icons.signal_wifi_2_bar)
    } else if (signalStrength < 0.25) {
      return const Icon(Icons.signal_wifi_3_bar)
    } */
    else {
      return const Icon(Icons.signal_wifi_4_bar);
    }
  }

  String _distanceFormat(double distance) {
    final km = distance / 1000;
    return km > 1 ? '${km.toStringAsFixed(2)} km' : '${distance.truncate()} m';
  }
}
