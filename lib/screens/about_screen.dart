import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/app_package_model.dart';
import 'package:road_wave_fm_ui/widgets/app_bar_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appPackage = context.watch<AppPackageModel>();

    return Scaffold(
      appBar: buildAppBar(context, title: 'About'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Version: ${appPackage.version}'),
          Text('Build: ${appPackage.buildNumber}'),
          const Text(
              'This application is a work in progress. Visit our repository to contribute and report issues.'),
          ElevatedButton(
            child: const Text('Github'),
            onPressed: () {
              launch('https://github.com/LinkedMink/road_wave_fm_ui');
            },
          ),
        ],
      ),
    );
  }
}
