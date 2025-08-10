import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BranchWidget extends StatefulWidget {
  final String name;
  const BranchWidget({
    required this.name,
    super.key,
  });

  @override
  State<BranchWidget> createState() => _BranchWidgetState();
}

class _BranchWidgetState extends State<BranchWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      margin: EdgeInsets.all(10.sp),
      width: context.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 2,
            ),
          ]),
      child: Text(widget.name),
    );
  }
}
