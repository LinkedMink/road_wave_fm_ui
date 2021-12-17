import 'package:flutter/material.dart';

import '/constants/asset.dart';
import '/models/asset_model.dart';
import '/widgets/app_bar_builder.dart';
import '/widgets/markdown_view.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'License'),
      body: Card(
          margin: const EdgeInsets.all(8.0),
          child: buildTextAssetProvider(Asset.license, const MarkdownView())),
    );
  }
}
