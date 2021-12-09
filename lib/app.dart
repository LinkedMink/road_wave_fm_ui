import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/providers.dart';
import '/constants/screens.dart';
import '/constants/theme.dart';

class RoadWaveFmApp extends StatelessWidget {
  const RoadWaveFmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: appProviders,
        child: MaterialApp(
          title: 'Road Wave FM',
          theme: appTheme,
          initialRoute: '/',
          routes: screenRoutes
              .map((key, value) => MapEntry(value.name, value.factory)),
        ));
  }
}
