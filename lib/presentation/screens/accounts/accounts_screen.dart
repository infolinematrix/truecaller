import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/accounts/account_controller.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/functions.dart';
import 'package:truecaller/utils/ui_helper.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key, required this.parent});

  final AccountsModel parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountProvider(parent.id));
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(index: 2),
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  title: Text(parent.name.toUpperCase()),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Iconsax.add_square5,
                        size: 28.0.sp,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        GoRouter.of(context).push("/accounts/create",
                            extra: {'parent': parent});
                      },
                    ),
                    UIHelper.horizontalSpaceMedium()
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50.0.h),
                    child: const SearchBar(),
                  ),
                ),
              ];
            },
            body: accounts.when(
              error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (data) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0.h),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        onTap: () => GoRouter.of(context).pushNamed('STATEMENT',
                            params: {'id': '1', 'name': 'SUBHA'}),
                        leading: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: Color(randomColor[randomNumber(
                                min: 0, max: randomColor.length - 1)]),
                            height: 40.0.sp,
                            width: 40.0.sp,
                            child: Text(
                              "M",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        title: const Text(
                          "Head Account",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text("Description of account"),
                        trailing: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: Theme.of(context).disabledColor,
                            height: 25.0.sp,
                            width: 25.0.sp,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )),
      ),
    );
  }
}
