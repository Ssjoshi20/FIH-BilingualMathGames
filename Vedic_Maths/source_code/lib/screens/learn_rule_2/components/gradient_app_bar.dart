import 'package:flutter/material.dart';
import 'package:vedicmath/screens/my_home/my_home_screen.dart';

import 'package:vedicmath/screens/welcome/welcome_screen.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double height;
  final Color backgroundColor;

  const GradientAppBar({Key? key, 
    required this.title,
    this.height = kToolbarHeight,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Navigate back to WelcomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}