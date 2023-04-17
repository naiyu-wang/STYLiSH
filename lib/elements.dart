import 'package:flutter/material.dart';

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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
