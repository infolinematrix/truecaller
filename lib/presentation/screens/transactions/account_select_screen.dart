import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/functions.dart';

import 'transaction_controller.dart';

class AccountSelectScreen extends ConsumerWidget {
  const AccountSelectScreen({super.key, required this.allowedTransactionType});

  final String allowedTransactionType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts =
        ref.watch(transactionAccountProvider(allowedTransactionType.trim()));
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).canvasColor,
                title: const Text("SELECT ACCOUNT"),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(45.0.h),
                  child: const SearchBar(),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0.sp, vertical: 0),
            child: accounts.when(
              error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    AccountsModel account = data[index];
                    return ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -2),
                      leading: ClipOval(
                        child: Container(
                          alignment: Alignment.center,
                          color: Color(randomColor[randomNumber(
                              min: 0, max: randomColor.length - 1)]),
                          height: 40.0.sp,
                          width: 40.0.sp,
                          child: Text(
                            account.name[0],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      title: Text(
                        account.name,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        account.description,
                        maxLines: 1,
                      ),
                      onTap: () {
                        if (allowedTransactionType == 'PAYMENT') {
                          GoRouter.of(context)
                              .pushNamed("PAYMENT", extra: account);
                        }

                        if (allowedTransactionType == 'RECEIVE') {
                          GoRouter.of(context)
                              .pushNamed("RECEIVE", extra: account);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
