import 'package:flutter/material.dart';
import 'package:stylish/mapPage.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final ThemeData theme;

  const MainAppBar({super.key, required this.appBar, required this.theme});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Image.asset('assets/stylish_logo.png', width: 150, fit: BoxFit.cover),
      elevation: 5.0,
      backgroundColor: theme.appBarTheme.backgroundColor,
      shadowColor: theme.appBarTheme.shadowColor,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: const Icon(
                Icons.map,
                size: 26.0,
              ),
            ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
