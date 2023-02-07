import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.txn,
  }) : super(key: key);

  final TransactionsModel txn;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      leading: DateWidget(strDate: txn.txnDate!.toString()),
      title: Text(
        txn.description!,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (txn.txnType == 'RECEIVE')
                Icon(
                  Iconsax.import_2,
                  size: 12.sp,
                  color: Colors.blue,
                ),
              if (txn.txnType == 'PAYMENT')
                Icon(
                  Iconsax.export_3, //import_2
                  size: 12.sp, color: Colors.red,
                ),
              UIHelper.horizontalSpaceExtraSmall(),
              Text(
                txn.accountName!,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${txn.txnType == 'PAYMENT' ? '-' : '+'} ${formatCurrency(txn.amountDr)}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: txn.txnType == 'PAYMENT'
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).primaryColor),
          ),
          Text(
            txn.narration!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
