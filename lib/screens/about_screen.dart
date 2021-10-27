import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/widgets/navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Work in progress'),
          ElevatedButton(
            child: const Text('Git Repo'),
            onPressed: () {
              launch('https://github.com/LinkedMink/road_wave_fm_ui');
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBar(selectedScreen: Screen.about),
    );
  }
}
