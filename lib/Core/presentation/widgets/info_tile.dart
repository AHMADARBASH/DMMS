import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Widget? trailing;

  const InfoTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.appColors.primary),
      title: Text(title, style: context.textTheme.bodyMedium),
      subtitle: Text(value),
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppPadding.p6,
      ),
      trailing: trailing,
    );
  }
}
