import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/accounts/account_controller.dart';
import 'package:truecaller/utils/index.dart';

import '../error.dart';

class AccountSearchScreen extends ConsumerWidget {
  const AccountSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    final accounts = ref.watch(accountSearchProvider);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              FormBuilder(
                key: formKey,
                child: SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  title: const Text('SEARCH'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(45.0.h),
                    child: Container(
                      height: 45.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Card(
                        elevation: .50,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          side: BorderSide(
                              width: .50,
                              color: Theme.of(context).disabledColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 0.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SlideInLeft(
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(Iconsax.search_normal)),

                              Expanded(
                                child: FormBuilderTextField(
                                    name: 'searchText',
                                    autofocus: true,
                                    initialValue:
                                        ref.watch(searchStringProvider),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (val) {
                                      ref
                                          .read(searchStringProvider.state)
                                          .update(
                                              (state) => val.toString().trim());

                                      ref
                                          .read(accountSearchProvider.notifier)
                                          .search();
                                    }),
                              ),
                              //
                              SlideInRight(
                                  duration: const Duration(milliseconds: 300),
                                  child: Text("SEARCH",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: accounts.when(
              error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final AccountsModel account = data[index];
                    return ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
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
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      title: Text(
                        account.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        account.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed('STATEMENT', extra: account);
                      },
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
