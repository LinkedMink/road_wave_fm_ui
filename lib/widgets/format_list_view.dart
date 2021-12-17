import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/format_list_model.dart';
import '/widgets/format_checkbox.dart';

class FormatListView extends StatefulWidget {
  const FormatListView({Key? key}) : super(key: key);

  @override
  State<FormatListView> createState() => FormatListViewState();
}

class FormatListViewState extends State<FormatListView> {
  FormatListModel? _listModel;

  @override
  void dispose() {
    _listModel?.saveSelectedFormats();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listModel = context.watch<FormatListModel>();
    final checkboxes = listModel.formatModels
        .map((m) => ChangeNotifierProvider.value(
            value: m, child: const FormatCheckbox()))
        .toList();

    _listModel = listModel;

    return ListView(
      children: checkboxes,
      shrinkWrap: true,
    );
  }
}
