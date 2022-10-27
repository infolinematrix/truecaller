import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

import '../../../utils/functions.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  AnimationController? _hideFabAnimation;

  @override
  initState() {
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _hideFabAnimation!.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation?.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation?.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        bottomNavigationBar: const BottomNavigation(
          index: 0,
        ),
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation!,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            elevation: 8,
            onPressed: () {},
            child: const Icon(Icons.code),
          ),
        ),
        drawer: const DrawerNavigation(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).canvasColor,
                title: const Text("FINDO"),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Iconsax.notification))
                ],
              ),
              SliverAppBar(
                backgroundColor: Theme.of(context).canvasColor,
                pinned: true,
                expandedHeight: 45.h,
                stretch: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                  child: InkWell(
                    onTap: () =>
                        GoRouter.of(context).pushNamed("ACCOUNTS/SEARCH"),
                    child: const SearchBar(),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: UIHelper.verticalSpaceMedium()),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 85.h,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 90.w,
                        child: Container(
                          margin: EdgeInsets.only(left: 8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Color(randomColor[randomNumber(
                                          min: 0,
                                          max: randomColor.length - 1)]),
                                      height: 40.0.sp,
                                      width: 40.0.sp,
                                      child: Text(
                                        "M",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    // child: Container(
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: 4.0.sp, vertical: 2.0.sp),
                                    //   decoration: BoxDecoration(
                                    //     color: Theme.of(context).errorColor,
                                    //     borderRadius: const BorderRadius.all(
                                    //         Radius.circular(20)),
                                    //   ),
                                    //   child: FittedBox(
                                    //     child: Text(
                                    //       "124",
                                    //       style: Theme.of(context)
                                    //           .textTheme
                                    //           .subtitle2!
                                    //           .copyWith(
                                    //               fontSize: 8.0.sp,
                                    //               fontWeight: FontWeight.bold,
                                    //               color: Theme.of(context)
                                    //                   .canvasColor),
                                    //     ),
                                    //   ),
                                    // ),

                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.sp,
                                            vertical: 2.0.sp),
                                        color: const Color(0xffF8742C),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "1223",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    fontSize: 8.0.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .canvasColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceSmall(),
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0.w),
                                  child: Text(
                                    "My Account Book",
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              UIHelper.verticalSpaceExtraSmall(),
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0.w),
                                  child: Text(
                                    "12 min ago",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: UIHelper.verticalSpaceMedium(),
              ),

              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              //     child: BoxedContainer(
              //         content: Row(
              //       children: [
              //         TextButton(
              //             onPressed: () {
              //               GoRouter.of(context).pushNamed("PAYMENT");
              //             },
              //             child: const Text("PAYMENT")),
              //         TextButton(
              //             onPressed: () {
              //               GoRouter.of(context).pushNamed("RECEIPT");
              //             },
              //             child: const Text("RECEIPT")),
              //         TextButton(
              //             onPressed: () {
              //               GoRouter.of(context).pushNamed("TRANSFER");
              //             },
              //             child: const Text("TRANSFER")),
              //         TextButton(
              //             onPressed: () {
              //               GoRouter.of(context).pushNamed("ACCOUNTS/SEARCH");
              //             },
              //             child: const Text("SEARCH")),
              //       ],
              //     )),
              //   ),
              // ),

              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.all(16.0.sp),
              //     child: BoxedContainer(
              //       content: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Expanded(
              //               child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "Switch to full Screen",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .titleMedium!
              //                     .copyWith(fontWeight: FontWeight.w500),
              //               ),
              //               UIHelper.verticalSpaceSmall(),
              //               const Text(
              //                   "I gave it a border, but it would be nice to have rounded borders."),
              //               UIHelper.verticalSpaceSmall(),
              //               Row(
              //                 children: [
              //                   TextButton(
              //                     onPressed: (() => null),
              //                     child: const Text("Read more"),
              //                   ),
              //                   UIHelper.horizontalSpaceMedium(),
              //                   TextButton(
              //                     onPressed: (() => null),
              //                     child: const Text("Dismiss"),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           )),
              //           Icon(
              //             Iconsax.bank4,
              //             size: 50.sp,
              //             color: Theme.of(context).primaryColor,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              SliverToBoxAdapter(
                child: UIHelper.verticalSpaceMedium(),
              ),
              SliverFixedExtentList(
                itemExtent: 55.h, // I'm forcing item heights
                delegate:
                    SliverChildBuilderDelegate(childCount: 2, (context, index) {
                  return ListTile(
                    leading: const DateWidget(),
                    title: Text(
                      "Account Head",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Subtitle",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "12,456",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          "Payment",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
