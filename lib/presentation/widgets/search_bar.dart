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
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          side: BorderSide(width: 1, color: Theme.of(context).disabledColor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 0.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Iconsax.search_normal),
              const Expanded(child: SizedBox.shrink()),
              Text("SEARCH", style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}
