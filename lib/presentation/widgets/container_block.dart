import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxedContainer extends StatelessWidget {
  const BoxedContainer({
    Key? key,
    required this.content,
    this.color,
    this.padding,
    this.borderColor,
  }) : super(key: key);

  final Widget content;
  final Color? color;
  final Color? borderColor;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: Border.all(
          color: borderColor ?? Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0.sp),
        ),
      ),
      padding: EdgeInsets.all(padding ?? 16.0.sp),
      width: double.infinity,
      child: content,
    );
  }
}
