import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxedContainer extends StatelessWidget {
  const BoxedContainer({Key? key, required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: EdgeInsets.all(16.0.sp),
      width: double.infinity,
      child: content,
    );
  }
}
