import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/index.dart';

import 'transactions_controller.dart';

class MonthlyTransactionsScreen extends ConsumerWidget {
  const MonthlyTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(monthlyTransactions);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).canvasColor,
              title: const Text('MONTHLY TRANSACTIONS'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: transactions.when(
            error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            data: (data) {
              if (data.isEmpty) {
                return const BoxedContainer(content: Text("No data found"));
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TransactionItem(txn: data[index]);
                  },
                );
              }
            }),
      ),
    );
  }
}
