import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

class AppUpdate extends StatelessWidget {
  const AppUpdate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
        child: BoxedContainer(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "NEW UPDATE AVAILABLE",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  const Text(
                      "I gave it a border, but it would be nice to have rounded borders."),
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text("UPDATE NOW"),
                      ),
                      UIHelper.horizontalSpaceMedium(),
                      TextButton(
                        onPressed: () {},
                        child: const Text("LATER"),
                      ),
                    ],
                  ),
                ],
              )),
              Icon(
                Iconsax.arrow_square_down,
                size: 50.sp,
                color: Theme.of(context).secondaryHeaderColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
