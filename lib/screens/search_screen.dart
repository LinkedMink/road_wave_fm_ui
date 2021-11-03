import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/widgets/format_grid_view.dart';
import 'package:road_wave_fm_ui/widgets/navigation_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
              ),
            ),
            const FormatGridView(),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBar(selectedScreen: Screen.search),
    );
  }
}
