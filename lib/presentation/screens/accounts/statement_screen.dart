import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/presentation/screens/accounts/account_statement_controller.dart';
import 'package:truecaller/presentation/screens/home/home_controller.dart';

import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';
import 'package:intl/intl.dart';

class AccountStatementScreen extends ConsumerWidget {
  const AccountStatementScreen({super.key, required this.account});

  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    final transactions =
        ref.watch(accountTransactions({'accountNo': account.id}));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text("STATEMENT - ${account.name.toUpperCase()}"),
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
            ),
          ),
        ],
      ),
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
                    height: 0,
                    color: Theme.of(context).dividerColor,
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
                                  await ref
                                      .watch(accountTransactions(
                                          {'accountNo': account.id}).notifier)
                                      .delete(txnId: txn.id)
                                      .then((value) {
                                    if (value == true) {
                                      EasyLoading.showSuccess("Deleted..");
                                      ref.invalidate(accountTransactions);
                                      ref.invalidate(homeDataProvider);
                                    }
                                  });
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
    );
  }
}
