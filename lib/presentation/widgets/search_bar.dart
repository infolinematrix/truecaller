import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Card(
        elevation: .50,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          side: BorderSide(width: .50, color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 0.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideInLeft(
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Iconsax.search_normal)),
              const Expanded(child: SizedBox.shrink()),
              SlideInRight(
                  duration: const Duration(milliseconds: 300),
                  child: Text("SEARCH",
                      style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
        ),
      ),
    );
  }
}
