import 'package:flutter/material.dart';

class PrefixIcon extends StatelessWidget {
  final IconData? icon;
  const PrefixIcon({
    Key? key,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(
        icon,
      ),
    );
  }
}
