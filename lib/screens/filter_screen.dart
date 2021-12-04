import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/widgets/app_bar_builder.dart';
import 'package:road_wave_fm_ui/widgets/format_grid_view.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Filter By'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[Text('Formats'), FormatGridView()]),
    );
  }
}
