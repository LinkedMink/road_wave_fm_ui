import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    if (signalStrength < 0.15) {
      return const Icon(MdiIcons.wifiStrengthOutline);
    } else if (signalStrength < 0.4) {
      return const Icon(MdiIcons.wifiStrength1);
    } else if (signalStrength < 0.6) {
      return const Icon(MdiIcons.wifiStrength2);
    } else if (signalStrength < 0.8) {
      return const Icon(MdiIcons.wifiStrength3);
    } else {
      return const Icon(MdiIcons.wifiStrength4);
    }
  }

  String _distanceFormat(double distance) {
    final km = distance / 1000;
    return km > 1 ? '${km.toStringAsFixed(2)} km' : '${distance.truncate()} m';
  }
}
