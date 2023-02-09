import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';
import 'package:pie_chart/pie_chart.dart';

class MonthSummary extends StatelessWidget {
  const MonthSummary({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Expenses": data['expensesPercentage'],
      "Savings": data['savingsPercentage'],
    };

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
                    child: PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: MediaQuery.of(context).size.width / 5,
                      chartRadius: MediaQuery.of(context).size.width / 5.0.w,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 18.0.sp,
                      centerText: "",
                      legendOptions: const LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          strToMonthLong(DateTime.now().toString()),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        // UIHelper.verticalSpaceSmall(),
                        const Text(
                          "Income & Expenditure Summary",
                          textAlign: TextAlign.right,
                        ),
                        // UIHelper.verticalSpaceMedium(),
                      ],
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
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
                                color: Theme.of(context).colorScheme.error,
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
