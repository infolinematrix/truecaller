import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

import 'budget_controller.dart';

class BudgetReportScreen extends ConsumerWidget {
  const BudgetReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(budgetReportProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('BUDGET REPORT'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: accounts.when(
          error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) {
            if (data.isEmpty) {
              return const BoxedContainer(content: Text("No data found"));
            } else {
              return Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SizedBox(
                          height: 1.h,
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth * .30,
                                color: Colors.red,
                              ),
                              // Container(
                              //   width: ScreenUtil().scaleWidth * .70,
                              //   color: Colors.grey.shade50,
                              // ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(data[index]['accountName'].toString()),
                          subtitle: Text(data[index]['budget'].toString()),
                          trailing: Text(
                            formatCurrency(data[index]['spentAmount']),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
