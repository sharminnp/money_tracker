import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.indent,
    this.thickness,
    this.width,
  });

  final double? indent;
  final double? thickness;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      thickness: thickness,
      color: Theme.of(context).dividerColor,
    );
  }
}
