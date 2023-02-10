import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/presentation/widgets/index.dart';

class TodaysTransactionWidget extends StatelessWidget {
  const TodaysTransactionWidget({Key? key, required this.txns})
      : super(key: key);

  final List<TransactionsModel> txns;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 60.h, // I'm forcing item heights
      delegate:
          SliverChildBuilderDelegate(childCount: txns.length, (context, index) {
        return TransactionItem(txn: txns[index]);
      }),
    );
  }
}
