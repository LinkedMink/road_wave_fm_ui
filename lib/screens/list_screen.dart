import 'package:flutter/material.dart';

import '/widgets/app_bar_builder.dart';
import '/widgets/station_list_view.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[const Text('List'), StationListView()]),
    );
  }
}
