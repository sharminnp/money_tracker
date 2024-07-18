import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';

class AppTextfield extends StatefulWidget {
  const AppTextfield({
    this.hintText,
    this.title,
    this.onTap,
    this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplete,
    this.hideBorder = false,
    this.avoidFillColor = false,
    this.autofocus = false,
    super.key,
    this.onChanged,
    this.onSaved,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? title;
  final String? hintText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final bool hideBorder;
  final bool avoidFillColor;
  final bool autofocus;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  bool filled = false;

  @override
  void initState() {
    if (!widget.avoidFillColor) {
      widget.controller?.addListener(() {
        filled = widget.controller?.text.isNotEmpty ?? false;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: UiColors.ternary,
      ),
      focusNode: widget.focusNode,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      controller: widget.controller,
      onChanged: widget.onChanged,
      autofocus: widget.autofocus,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      keyboardType: widget.keyboardType,
      cursorColor: UiColors.secondary,
      decoration: InputStyle.getInputDecoration(
        hideBorder: widget.hideBorder,
        label: widget.title,
        enabled: widget.enabled,
        filled: filled,
        hintText: widget.hintText,
      ),
    );
  }
}

class InputStyle {
  static InputDecoration getInputDecoration({
    required bool enabled,
    required bool hideBorder,
    String? label,
    bool filled = false,
    String? hintText,
  }) {
    return InputDecoration(
      label: label != null
          ? Text(
              label,
              style: const TextStyle(
                color: UiColors.ternary,
                fontSize: 13,
              ),
            )
          : null,
      filled: filled,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      hintText: hintText,
      hintMaxLines: 1,
      hintStyle: const TextStyle(
        color: UiColors.ternary,
        fontSize: 13,
      ),
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        color: UiColors.ternary,
        fontSize: 13,
      ),
      border: _getBorder(hideBorder, UiColors.primary),
      focusedBorder: _getBorder(hideBorder, UiColors.primary),
      enabledBorder: _getBorder(hideBorder, UiColors.ternary),
      errorBorder: _getBorder(hideBorder, UiColors.error),
      disabledBorder: _getBorder(hideBorder, UiColors.grey3.withOpacity(0.3)),
    );
  }

  static InputBorder _getBorder(bool hideBorder, Color color) => hideBorder
      ? InputBorder.none
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color),
        );
}
