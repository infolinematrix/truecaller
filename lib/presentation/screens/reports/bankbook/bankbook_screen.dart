import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/index.dart';

import 'bankbook_controller.dart';

class BankBookScreenReport extends ConsumerWidget {
  const BankBookScreenReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final transactions = ref.watch(bankBookProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            FormBuilder(
              key: formKey,
              child: SliverAppBar(
                backgroundColor: Theme.of(context).canvasColor,
                title: const Text('BANK BOOK'),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
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
