import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const navigationBarItemWithConstraints = BoxConstraints.expand(width: 80.0);

class NavigationBarItem extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  NavigationBarItem({
    required this.title,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) => Opacity(
        opacity: null == onPressed ? 0.5 : 1.0,
        child: IconButton(
          icon: Text(title),
          constraints: navigationBarItemWithConstraints,
          onPressed: onPressed,
        ),
      );
}
