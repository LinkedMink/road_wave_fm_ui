import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/format_model.dart';

class FormatCheckbox extends StatelessWidget {
  const FormatCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FormatModel>();

    return Row(children: [
      Checkbox(
          value: model.isSelected,
          onChanged: (isChecked) => {model.isSelected = isChecked ?? false}),
      Text(model.name),
    ]);
  }
}
