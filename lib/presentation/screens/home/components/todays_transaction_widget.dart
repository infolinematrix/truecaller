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
    // return SliverToBoxAdapter(
    //   child: ListView.builder(
    //     itemCount: txns.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return TransactionItem(txn: txns[index]);
    //     },
    //   ),
    // );
    return SliverFixedExtentList(
      itemExtent: 50.h, // I'm forcing item heights
      delegate:
          SliverChildBuilderDelegate(childCount: txns.length, (context, index) {
        return TransactionItem(txn: txns[index]);
        // return ListTile(
        //   // leading:  DateWidget(),
        //   title: Text(
        //     "Account Head",
        //     style: Theme.of(context)
        //         .textTheme
        //         .bodyText1!
        //         .copyWith(fontWeight: FontWeight.w500),
        //   ),
        //   subtitle: Row(
        //     children: [
        //       Text(
        //         "Subtitle",
        //         style: Theme.of(context).textTheme.bodySmall,
        //       )
        //     ],
        //   ),
        //   trailing: Column(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Text(
        //         "12,456",
        //         style: Theme.of(context).textTheme.subtitle2,
        //       ),
        //       Text(
        //         "Payment",
        //         style: Theme.of(context).textTheme.bodySmall,
        //       ),
        //     ],
        //   ),
        // );
      }),
    );
  }
}
