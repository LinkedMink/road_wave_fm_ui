import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/models/station.dart';
import 'package:road_wave_fm_ui/style/theme.dart';

class StationCard extends StatelessWidget {
  final Station station;

  const StationCard({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: appTheme.dividerColor),
          left: BorderSide(width: 1.0, color: appTheme.dividerColor),
          right: BorderSide(width: 1.0, color: appTheme.dividerColor),
          bottom: BorderSide(width: 1.0, color: appTheme.dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            _signalIconFromStrength(station.signalStrength),
            Column(
              children: [
                Text(
                    '${station.callSign}: ${station.frequency} ${station.protocol}'),
                Text('Format: ${station.format}'),
                Text('Distance: ${station.distance}'),
              ],
            ),
          ]),
          const Icon(Icons.map)
        ],
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
