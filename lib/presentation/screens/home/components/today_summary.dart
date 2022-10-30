import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

class TodaySummary extends StatelessWidget {
  const TodaySummary({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: BoxedContainer(
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Summary",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      const Text(
                          "I gave it a border, but it would be nice to have rounded borders."),
                      UIHelper.verticalSpaceMedium(),
                    ],
                  )),
                  Icon(
                    Iconsax.calendar_1,
                    size: 50.sp,
                    color: Theme.of(context).toggleableActiveColor,
                  )
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      // fit: FlexFit.tight,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            "Income",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                          UIHelper.verticalSpaceExtraSmall(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatCurrency(data['income']),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              UIHelper.horizontalSpaceSmall(),
                              Icon(
                                Iconsax.import_1,
                                color: Theme.of(context).hoverColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: VerticalDivider(
                        thickness: 0.8,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Flexible(
                      // fit: FlexFit.tight,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            "Expenditure",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                          UIHelper.verticalSpaceExtraSmall(),
                          Row(
                            children: [
                              Text(
                                formatCurrency(data['expenditure']),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              UIHelper.horizontalSpaceSmall(),
                              Icon(
                                Iconsax.export_1,
                                color: Theme.of(context).errorColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
