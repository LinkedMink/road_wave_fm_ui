import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/constants/theme.dart';

class NavigationBar extends StatelessWidget {
  final Screen selectedScreen;

  const NavigationBar({Key? key, required this.selectedScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.dividerColor,
        boxShadow: [
          BoxShadow(
            color: appTheme.dividerColor,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: selectedScreen.index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          )
        ],
        onTap: (int index) {
          Navigator.popAndPushNamed(
              context, screenRoutes[Screen.values[index]]!.name);
        },
      ),
    );
  }
}
