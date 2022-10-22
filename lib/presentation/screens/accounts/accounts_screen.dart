import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/application/functions.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/utils/ui_helper.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(
        index: 2,
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('ACCOUNTS'),
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
                    onPressed: () {},
                  ),
                  UIHelper.horizontalSpaceMedium()
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    // color: Colors.green,
                    child: Card(
                      child: SizedBox(
                        height: 40.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Iconsax.search_normal),
                              Icon(Iconsax.microphone),
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
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0.h),
            child: ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: Color(randomColor[
                          randomNumber(min: 0, max: randomColor.length - 1)]),
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
          ),
        ),
      ),
    );
  }
}
