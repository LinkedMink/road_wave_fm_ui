import 'package:flutter/material.dart';
import '/widgets/app_bar_builder.dart';
import '/widgets/format_grid_view.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, title: 'Filter'),
        body: const FormatGridView());
  }
}
