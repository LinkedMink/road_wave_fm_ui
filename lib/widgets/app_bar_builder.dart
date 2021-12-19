import 'package:flutter/material.dart';

import '/constants/screens.dart';
import '/screens/action_screen.dart';

AppBar buildAppBar(BuildContext context, {String title = 'Road Wave FM'}) {
  final actions = <Widget>[];
  context.visitAncestorElements((element) {
    final screenParent = element.widget as Semantics;
    if (screenParent.child is ActionScreen) {
      final screenActions =
          (screenParent.child as ActionScreen).buildActionButtons(context);
      actions.addAll(screenActions);
    }

    return false;
  });

  final currentRoute = ModalRoute.of(context)?.settings.name;
  if (!appBarMenuOptionScreen.containsValue(currentRoute)) {
    actions.add(PopupMenuButton<AppBarMenuOption>(
        icon: const Icon(Icons.menu),
        tooltip: "Open Menu",
        onSelected: (option) {
          final targetRouteName = appBarMenuOptionScreen[option]!;
          final route = ModalRoute.of(context);
          if (route?.settings.name == targetRouteName) {
            return;
          }

          Navigator.pushNamed(context, targetRouteName);
        },
        itemBuilder: (context) => <PopupMenuEntry<AppBarMenuOption>>[
              const PopupMenuItem<AppBarMenuOption>(
                value: AppBarMenuOption.about,
                child: Text('About'),
              ),
              const PopupMenuItem<AppBarMenuOption>(
                value: AppBarMenuOption.license,
                child: Text('License'),
              )
            ]));
  }

  return AppBar(
    leading: Navigator.canPop(context)
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => {Navigator.pop(context)})
        : null,
    title: Text(title),
    actions: actions,
  );
}
