import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '/models/asset_model.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AssetModel<String>>();

    return Markdown(data: model.data);
  }
}
