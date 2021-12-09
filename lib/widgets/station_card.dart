import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/station_model.dart';

class StationCard extends StatelessWidget {
  const StationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final station = context.watch<StationModel>();

    return Card(
      child: ListTile(
        leading: _signalIconFromStrength(station.signalStrength),
        title: Text(
            '${station.callSign}: ${station.frequency} ${station.protocol}'),
        subtitle: Column(
          children: [
            Text('Format: ${station.format}'),
            Text('Distance: ${station.distance}')
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
}
