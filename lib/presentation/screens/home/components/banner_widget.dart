import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const Image(
            image: AssetImage('assets/images/banner1.png'),
          ),
        ),
      ),
    );
  }
}
