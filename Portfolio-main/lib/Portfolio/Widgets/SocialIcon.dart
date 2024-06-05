import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SocialIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Icon(
        icon,
        size: 30,
        color: Colors.grey,
      ),
    );
  }
}