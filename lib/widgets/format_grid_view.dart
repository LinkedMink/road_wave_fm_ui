import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/format_list_model.dart';
import '/models/format_model.dart';
import '/widgets/format_checkbox.dart';

class FormatGridView extends StatelessWidget {
  const FormatGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatModels = context
        .select<FormatListModel, List<FormatModel>>((m) => m.formatModels);
    final checkboxes = formatModels
        .map((m) => ChangeNotifierProvider.value(
            value: m, child: const FormatCheckbox()))
        .toList();

    return ListView(
      children: checkboxes,
      shrinkWrap: true,
    );
  }
}
