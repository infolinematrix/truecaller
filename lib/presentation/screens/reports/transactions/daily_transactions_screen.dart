import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';
import 'package:intl/intl.dart';
import 'transactions_controller.dart';

class DailyTransactionsScreen extends ConsumerWidget {
  const DailyTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final transactions = ref.watch(dailyTransactionsProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).canvasColor,
              title: const Text('DAILY TRANSACTIONS'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                IconButton(
                    onPressed: () {
                      // ref.watch(isFilterProvider) == true
                      //     ? ref
                      //         .watch(isFilterProvider.notifier)
                      //         .update((state) => false)
                      //     : ref
                      //         .watch(isFilterProvider.notifier)
                      //         .update((state) => true);
                    },
                    icon: Icon(
                      Iconsax.filter_square,
                      size: 24.sp,
                      color: Theme.of(context).primaryColorDark,
                    )),
              ],
            ),
          ];
        },
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ref.watch(isFilterProvider) == true
                ? FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0.sp),
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderDateTimePicker(
                              name: 'report_date',
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialValue: DateTime.now(),
                              inputType: InputType.both,
                              format: DateFormat('yyyy-MM-dd'),
                              onChanged: (v) {
                                // ref
                                //     .read(dateRangeProvider.notifier)
                                //     .update((state) {
                                //   return DateRangeModel(v!.start);
                                // });
                              },
                              decoration: InputDecoration(
                                labelText: 'Report Date',
                                iconColor: Colors.red,
                                suffixIcon: Icon(
                                  Iconsax.calendar,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: transactions.when(
                error: (error, stackTrace) => ErrorWidget(error.toString()),
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (data) {
                  return ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 5.0.h,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      TransactionsModel txn = data[index];
                      return SlideInDown(
                        duration: Duration(milliseconds: (index + 1) * 100),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            extentRatio: .20.w,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor:
                                    Theme.of(context).primaryColorLight,
                                foregroundColor:
                                    Theme.of(context).primaryColorDark,
                                icon: Iconsax.close_circle,
                                label: 'Delete',
                                onPressed: (context) async {
                                  AlertAction? action = await confirmDialog(
                                      context,
                                      '''Are you sure ?\nYou want delete transaction''');

                                  if (action == AlertAction.ok) {}
                                },
                              ),
                            ],
                          ),
                          child: TransactionItem(txn: txn),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
