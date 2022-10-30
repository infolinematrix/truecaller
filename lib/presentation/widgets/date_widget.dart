import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/utils/index.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key, required this.strDate}) : super(key: key);

  final String strDate;

  @override
  Widget build(BuildContext context) {
    final date = dateMap(strDate);

    return Container(
      // margin: EdgeInsets.symmetric(vertical: 1.h),
      clipBehavior: Clip.hardEdge,
      width: 45.w,
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).highlightColor,
            height: 14.sp,
            margin: EdgeInsets.only(bottom: 4.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date['month'],
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  date['day'],
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0.sp),
                ),
                Text(
                  date['year'],
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 8.sp),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
