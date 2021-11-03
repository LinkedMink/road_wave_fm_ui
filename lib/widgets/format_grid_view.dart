import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/models/format_model.dart';

class FormatGridView extends StatelessWidget {
  const FormatGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatList = context.watch<FormatListModel>();
    var checkboxes = formatList.formatModels
        .map((m) => ChangeNotifierProvider.value(
            value: m, child: const FormatCheckbox()))
        .toList();
    return GridView.count(crossAxisCount: 2, children: checkboxes);
  }
}

class FormatCheckbox extends StatelessWidget {
  const FormatCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.watch<FormatModel>();

    return Row(children: [
      Checkbox(
          value: model.isSelected,
          onChanged: (isChecked) => {model.isSelected = isChecked ?? false}),
      Text(model.name),
    ]);
  }
}
