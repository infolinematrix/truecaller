import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/accounts/account_controller.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

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
                    preferredSize: Size.fromHeight(45.0.h),
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
                      AccountsModel account = data[index];
                      return account.isSystem == false
                          ? SlideInDown(
                              duration:
                                  Duration(milliseconds: (index + 1) * 100),
                              child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  extentRatio: .40.w,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      icon: Iconsax.close_circle,
                                      label: 'Delete',
                                      onPressed: (context) async {
                                        AlertAction? action = await confirmDialog(
                                            context,
                                            "WARNING\nYou want delete transaction. \nYou will loose all the transaction happend on this account.");

                                        if (action == AlertAction.ok) {
                                          await ref
                                              .read(accountProvider(parent.id)
                                                  .notifier)
                                              .delete(
                                                  parentId: parent.id,
                                                  id: account.id)
                                              .then((value) {
                                            if (value == true) {
                                              EasyLoading.showSuccess(
                                                  "Success");
                                            }
                                          });
                                        }
                                      },
                                    ),
                                    SlidableAction(
                                      icon: Iconsax.edit,
                                      label: 'Update',
                                      onPressed: (context) {},
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  onTap: () => account.hasChild == false
                                      ? GoRouter.of(context).pushNamed(
                                          'STATEMENT',
                                          extra: account)
                                      : GoRouter.of(context).push('/accounts',
                                          extra: {'parent': account}),
                                  leading: ClipOval(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Color(randomColor[randomNumber(
                                          min: 0,
                                          max: randomColor.length - 1)]),
                                      height: 40.0.sp,
                                      width: 40.0.sp,
                                      child: Text(
                                        account.name[0],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    account.name,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    account.description,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  trailing: account.hasChild == true
                                      ? ClipOval(
                                          child: Container(
                                            alignment: Alignment.center,
                                            color:
                                                Theme.of(context).disabledColor,
                                            height: 25.0.sp,
                                            width: 25.0.sp,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12.0.sp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            )
                          : SlideInDown(
                              duration:
                                  Duration(milliseconds: (index + 1) * 100),
                              child: ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                onTap: () => account.hasChild == false
                                    ? GoRouter.of(context)
                                        .pushNamed('STATEMENT', extra: account)
                                    : GoRouter.of(context).push('/accounts',
                                        extra: {'parent': account}),
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
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  account.name,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  account.description,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: account.hasChild == true
                                    ? ClipOval(
                                        child: Container(
                                          alignment: Alignment.center,
                                          color:
                                              Theme.of(context).disabledColor,
                                          height: 25.0.sp,
                                          width: 25.0.sp,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12.0.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
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
