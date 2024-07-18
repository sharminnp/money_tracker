import 'package:flutter/material.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    this.size = 32,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.wallet,
      color: UiColors.primary,
      size: size,
    );
  }
}
