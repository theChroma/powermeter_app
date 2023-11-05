import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation extends StatefulWidget {
  final Widget child;
  final List<BottomNavigationBarItem> destinations;
  final List<Widget>? actions;

  const Navigation({
    required this.child,
    required this.destinations,
    this.actions,
    super.key
  });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      appBar: AppBar(
        title: Text(widget.destinations[_currentPageIndex].label!),
        actions: widget.actions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        mouseCursor: MaterialStateMouseCursor.clickable,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
            context.goNamed(widget.destinations[index].label!);
          });
        },
        currentIndex: _currentPageIndex,
        items: widget.destinations,
      ),
    );
  }
}
