import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/format_list_model.dart';
import '/screens/action_screen.dart';
import '/widgets/app_bar_builder.dart';
import '/widgets/format_list_view.dart';

class FilterScreen extends StatelessWidget implements ActionScreen {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, title: 'Filter'),
        body: const FormatListView());
  }

  @override
  List<Widget> buildActionButtons(BuildContext context) {
    return [
      Consumer<FormatListModel>(
          builder: (context, model, child) => IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Clear Selected',
              onPressed: model.selectedFormatIds.isNotEmpty
                  ? () => model.clearSelectedFormats()
                  : null)),
      Consumer<FormatListModel>(
          builder: (context, model, child) => IconButton(
              icon: const Icon(Icons.restore),
              tooltip: 'Restore Selected',
              onPressed: model.hasModifiedSelected
                  ? () => model.restoreSelectedFormats()
                  : null)),
    ];
  }
}
