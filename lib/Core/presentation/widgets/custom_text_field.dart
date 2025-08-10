import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String? hint;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool hasSuffix;
  final Color? backgroundColor;
  final TextInputType? keyBoardType;
  final TextInputAction? action;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? initialValue;
  final bool? enabled;
  final Widget? helper;
  final void Function(String)? onChanged;
  bool isPassword;

  final String? lable;
  CustomTextField({
    this.hint,
    this.icon,
    this.suffixIcon,
    this.action,
    required this.controller,
    required this.hasSuffix,
    required this.validator,
    this.isPassword = false,
    this.initialValue,
    this.lable,
    this.keyBoardType,
    this.backgroundColor,
    this.enabled,
    this.helper,
    this.onChanged,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      enabled: widget.enabled ?? true,
      validator: widget.validator,
      initialValue: widget.initialValue,
      controller: widget.controller,
      textInputAction: widget.action,
      cursorColor: context.appColors.primary,
      keyboardType: widget.keyBoardType,
      obscureText: widget.isPassword,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        helper: widget.helper,
        contentPadding: EdgeInsets.all(AppPadding.p12),
        labelStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.appColors.outline,
        ),
        labelText: widget.lable,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appColors.error),
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: context.appColors.primary,
              )
            : null,
        hintText: widget.hint,
        hintStyle: TextStyle(
            color: context.appColors.primaryContainer,
            fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: AppSize.s1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: context.appColors.primary,
            width: AppSize.s1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: context.appColors.primary,
            width: AppSize.s1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: AppSize.s0,
          ),
        ),
        filled: true,
        fillColor: widget.backgroundColor ?? context.appColors.surface,
        suffixIcon: !widget.hasSuffix
            ? null
            : widget.suffixIcon ??
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  child: Icon(
                    widget.isPassword ? Icons.visibility : Icons.visibility_off,
                    color: context.appColors.primary,
                  ),
                ),
      ),
    );
  }
}
