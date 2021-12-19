import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/format_model.dart';

class FormatCheckbox extends StatelessWidget {
  const FormatCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FormatModel>();

    return CheckboxListTile(
        value: model.isSelected,
        title: Text(model.name),
        onChanged: (isChecked) => {model.isSelected = isChecked ?? false});
  }
}
