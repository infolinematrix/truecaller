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
import 'cashbook_controller.dart';

class CashBookScreenReport extends ConsumerWidget {
  const CashBookScreenReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final transactions = ref.watch(cashBookProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('CASH BOOK'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                IconButton(
                    onPressed: () {
                      ref.watch(isFilterProvider) == true
                          ? ref
                              .watch(isFilterProvider.notifier)
                              .update((state) => false)
                          : ref
                              .watch(isFilterProvider.notifier)
                              .update((state) => true);
                    },
                    icon: Icon(
                      Iconsax.filter_square,
                      size: 24.sp,
                      color: Theme.of(context).primaryColorDark,
                    )),
                UIHelper.horizontalSpaceMedium()
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
                            child: FormBuilderDateRangePicker(
                              name: 'date_range',
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2030),
                              format: DateFormat('yyyy-MM-dd'),
                              onChanged: (v) {
                                ref
                                    .read(dateRangeProvider.notifier)
                                    .update((state) {
                                  return DateRangeModel(v!.start, v.end);
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Date Range',
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

                                  if (action == AlertAction.ok) {
                                    // await ref
                                    //     .watch(accountTransactions(
                                    //         {'accountNo': account.id}).notifier)
                                    //     .delete(txnId: txn.id)
                                    //     .then((value) {
                                    //   if (value == true) {
                                    //     EasyLoading.showSuccess("Deleted..");
                                    //     ref.invalidate(accountTransactions);
                                    //     ref.invalidate(homeDataProvider);
                                    //   }
                                    // });
                                  }
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
        // body: transactions.when(
        //   error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
        //   loading: () => const Center(child: CircularProgressIndicator()),
        //   data: (data) {
        //     if (data.isEmpty) {
        //       return const BoxedContainer(content: Text("No data found"));
        //     } else {
        //       return ListView.builder(
        //         itemCount: data.length,
        //         itemBuilder: (context, index) {
        //           return TransactionItem(txn: data[index]);
        //         },
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
