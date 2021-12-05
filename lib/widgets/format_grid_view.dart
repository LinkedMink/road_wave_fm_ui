import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/widgets/format_checkbox.dart';

class FormatGridView extends StatelessWidget {
  const FormatGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatList = context.watch<FormatListModel>();
    final checkboxes = formatList.formatModels
        .map((m) => ChangeNotifierProvider.value(
            value: m, child: const FormatCheckbox()))
        .toList();

    return ListView(
      children: checkboxes,
      shrinkWrap: true,
    );
  }
}
