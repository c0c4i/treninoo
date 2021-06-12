import 'package:flutter/material.dart';

class PrefixIcon extends StatelessWidget {
  final IconData icon;
  const PrefixIcon({
    Key key,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        size: Theme.of(context).iconTheme.size,
      ),
    );
  }
}
