import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenuWidget<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String lable;
  final FormFieldValidator<T> validator;

  const CustomDropDownMenuWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.lable,
    required this.validator,
  });

  @override
  State<CustomDropDownMenuWidget<T>> createState() =>
      _CustomDropDownMenuWidgetState<T>();
}

class _CustomDropDownMenuWidgetState<T>
    extends State<CustomDropDownMenuWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: widget.value,
      isExpanded: true,
      validator: widget.validator,
      style: context.textTheme.bodyLarge,
      menuMaxHeight: AppSize.s200,
      decoration: InputDecoration(
        label: Text(widget.lable),
        labelStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.appColors.outline,
        ),
        filled: true,
        fillColor: context.appColors.surface,
        contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.p12, horizontal: AppPadding.p16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(color: Colors.transparent),
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appColors.error),
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
      ),
      icon: Icon(Icons.arrow_drop_down, color: context.appColors.primary),
      items: widget.items,
      onChanged: widget.onChanged,
    );
  }
}
