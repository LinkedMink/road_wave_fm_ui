import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/models/format.dart';

class FormatGridView extends StatelessWidget {
  final List<Format> formats;

  const FormatGridView({Key? key, required this.formats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2);
  }
}
