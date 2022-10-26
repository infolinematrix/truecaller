import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/screens/groups/groups_controller.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/functions.dart';
import 'package:truecaller/utils/ui_helper.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(accountGroupProvider);
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(index: 2),
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  title: const Text('GROUPS'),
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
                        GoRouter.of(context).pushNamed('GROUPS/CREATE');
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
            body: groups.when(
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
                      AccountsModel group = data[index];
                      return ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        onTap: () => GoRouter.of(context)
                            .push('/accounts', extra: {'parent': group}),
                        leading: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: Color(randomColor[randomNumber(
                                min: 0, max: randomColor.length - 1)]),
                            height: 40.0.sp,
                            width: 40.0.sp,
                            child: Text(
                              group.name[0],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        title: Text(
                          group.name,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          group.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // style: Theme.of(context).textTheme.bodySmall,
                        ),
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
