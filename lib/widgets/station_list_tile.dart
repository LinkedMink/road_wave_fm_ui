import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/station_model.dart';

class StationListTile extends StatelessWidget {
  const StationListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final station = context.watch<StationModel>();
    toggleStation() {
      station.toggle();
    }

    return ListTile(
        leading: CircleAvatar(
            backgroundColor:
                station.isSelected ? theme.primaryColor : theme.backgroundColor,
            foregroundColor:
                station.isSelected ? theme.colorScheme.primary : null,
            child: _signalIconFromStrength(station.signalStrength)),
        title: Text(
            '${station.callSign}: ${station.frequency} ${station.protocol}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Format: ${station.format}'),
            Text('Distance: ${_distanceFormat(station.distance)}')
          ],
        ),
        trailing:
            IconButton(icon: const Icon(Icons.map), onPressed: toggleStation),
        selected: station.isSelected,
        onTap: toggleStation);
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
