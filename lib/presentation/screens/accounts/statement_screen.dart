import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/presentation/screens/accounts/account_statement_controller.dart';
import 'package:truecaller/presentation/screens/error.dart';

import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/functions.dart';
import 'package:truecaller/utils/ui_helper.dart';
import 'package:intl/intl.dart';

class AccountStatementScreen extends ConsumerWidget {
  const AccountStatementScreen({super.key, required this.account});

  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final transactions = ref.watch(transactionsProvider(account.id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(account.name.toUpperCase()),
        actions: [
          IconButton(
              onPressed: () {
                ref.watch(isFilterProvider.state).state == true
                    ? ref.watch(isFilterProvider.state).update((state) => false)
                    : ref.watch(isFilterProvider.state).update((state) => true);
              },
              icon: const Icon(
                Iconsax.filter_square,
                size: 28,
              )),
          UIHelper.horizontalSpaceMedium()
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ref.watch(isFilterProvider.state).state == true
              ? FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0.sp),
                        child: SizedBox(
                          height: inputHeight,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child: FormBuilderDateRangePicker(
                                  name: 'date_range',
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime(2030),
                                  format: DateFormat('yyyy-MM-dd'),
                                  // onChanged: _onChanged,
                                  decoration: const InputDecoration(
                                    labelText: 'Date Range',
                                    iconColor: Colors.red,
                                    suffixIcon: Icon(Iconsax.calendar),
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpaceSmall(),
                              Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: ButtonDefault(
                                        color: Color(randomColor[randomNumber(
                                            min: 5,
                                            max: randomColor.length - 1)]),
                                        onTap: () {},
                                        text: Icon(
                                          Iconsax.search_favorite,
                                          size: 16.0.sp,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: transactions.when(
              error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (data) {
                return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 5.0.h,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    TransactionsModel txn = data[index];
                    return TransactionItem(txn: txn);
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
