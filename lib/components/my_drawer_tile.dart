import 'package:flutter/material.dart';

class MyDraweTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const MyDraweTile({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      onTap: onTap,
    );
  }
}
