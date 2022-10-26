import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

class DailySummary extends ConsumerWidget {
  const DailySummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BoxedContainer(
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
                "Todays' Summary",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              UIHelper.verticalSpaceSmall(),
              const Text(
                  "I gave it a border, but it would be nice to have rounded borders."),
              UIHelper.verticalSpaceSmall(),
              Row(
                children: [
                  TextButton(
                    onPressed: (() => null),
                    child: const Text("Read more"),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  TextButton(
                    onPressed: (() => null),
                    child: const Text("Dismiss"),
                  ),
                ],
              ),
            ],
          )),
          Icon(
            Iconsax.bank4,
            size: 50.sp,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
