import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:flutter/material.dart';

class ErrorRefreshWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const ErrorRefreshWidget(
      {required this.onPressed, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.replay,
              color: context.appColors.primary,
            ),
          )
        ],
      ),
    );
  }
}
