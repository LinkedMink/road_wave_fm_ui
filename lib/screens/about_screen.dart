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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoCard(
              'Repository',
              const Text(
                  'This application is a work in progress. Visit our repository to contribute and report issues.'),
              link: const MapEntry('Visit Github Repository',
                  'https://github.com/LinkedMink/road_wave_fm_ui')),
          _buildInfoCard(
              'Package',
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyValueText('Version', appPackage.version),
                  _buildKeyValueText('Build', appPackage.buildNumber)
                ],
              )),
          _buildInfoCard('License', const Text('MIT'),
              link: const MapEntry('View License File',
                  'https://github.com/LinkedMink/road_wave_fm_ui/LICENSE'))
        ],
      ),
    );
  }

  _buildInfoCard(String title, Widget content, {MapEntry? link}) => Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        title: Text(title),
        subtitle: content,
        trailing: link != null
            ? IconButton(
                icon: const Icon(Icons.arrow_forward),
                tooltip: link.key,
                onPressed: () {
                  launch(link.value);
                },
              )
            : null,
      ));

  _buildKeyValueText(String key, String value) => Text.rich(TextSpan(
      text: '$key: ',
      children: [
        TextSpan(
            text: value, style: const TextStyle(fontWeight: FontWeight.normal))
      ],
      style: const TextStyle(fontWeight: FontWeight.bold)));
}
