import 'package:flutter/material.dart';

abstract class ActionScreen extends Widget {
  const ActionScreen({Key? key}) : super(key: key);

  List<IconButton> buildActionButtons(BuildContext context);
}
