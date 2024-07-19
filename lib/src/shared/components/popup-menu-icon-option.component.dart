import 'package:flutter/material.dart';

class PopupMenuIconOption extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Widget? customIcon;
  const PopupMenuIconOption({
    super.key,
    required this.label,
    this.icon,
    this.customIcon,
  }) : assert((icon != null && customIcon == null) ||
            (icon == null && customIcon != null));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [(icon != null) ? Icon(icon) : customIcon!, Text(label)],
    );
  }
}
