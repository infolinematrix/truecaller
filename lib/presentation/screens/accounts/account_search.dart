import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/utils/functions.dart';

class AccountSearchScreen extends ConsumerWidget {
  const AccountSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).canvasColor,
                title: const Text('SEARCH'),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0.h),
                  child: SizedBox(
                    width: double.infinity,
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
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
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
                  title: Text(
                    "Account name",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: const Text("Account Descripttion"),
                );
              }),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Card(
        //       child: SizedBox(
        //         height: 50.h,
        //         child: Padding(
        //           padding:
        //               EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 0.0.h),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               const Icon(Iconsax.search_normal),
        //               const Expanded(child: SizedBox.shrink()),
        //               Text("SEARCH",
        //                   style: Theme.of(context).textTheme.caption),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: ListView.builder(
        //         itemCount: 10,
        //         itemBuilder: (BuildContext context, int index) {
        //           return ListTile(
        //             dense: true,
        //             visualDensity:
        //                 const VisualDensity(horizontal: 0, vertical: -4),
        //             title: Text(
        //               "Account name",
        //               style: Theme.of(context).textTheme.bodyText1,
        //             ),
        //             subtitle: const Text("Account Descripttion"),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
