import 'package:flutter/material.dart';

class AppBarListenableBuilder extends ListenableBuilder implements PreferredSizeWidget {
  const AppBarListenableBuilder({
    required super.listenable,
    required super.builder,
    super.key,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;
}