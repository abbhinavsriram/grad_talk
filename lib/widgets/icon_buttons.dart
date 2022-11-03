import 'package:flutter/material.dart';
import 'package:grad_talk/theme.dart';

class IconBorder extends StatelessWidget {

  const IconBorder({Key? key, required this.icon, required this.onTap}) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.grey,
      onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 30,
            color: Colors.grey,
          )
        ),
      );

  }
}
