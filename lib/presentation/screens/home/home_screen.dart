import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/functions.dart';
import 'package:truecaller/utils/index.dart';

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
              // SliverToBoxAdapter(
              //   child: Container(
              //     margin: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
              //     padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              //     child: const Text("Findo"),
              //   ),
              // ),
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
                expandedHeight: 50.h,
                stretch: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  // margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                  // padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: InkWell(
                    onTap: () =>
                        GoRouter.of(context).pushNamed("ACCOUNTS/SEARCH"),
                    child: Container(
                      height: 50.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          side: BorderSide(
                              width: 1, color: Theme.of(context).disabledColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 0.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Iconsax.search_normal),
                              const Expanded(child: SizedBox.shrink()),
                              Text("SEARCH",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                              ClipOval(
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
                                    "250.50",
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
              // SliverToBoxAdapter(child: UIHelper.verticalSpaceMedium()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                  child: BoxedContainer(
                      content: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed("PAYMENT");
                          },
                          child: const Text("PAYMENT")),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed("RECEIPT");
                          },
                          child: const Text("RECEIPT")),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed("TRANSFER");
                          },
                          child: const Text("TRANSFER")),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed("ACCOUNTS/SEARCH");
                          },
                          child: const Text("SEARCH")),
                    ],
                  )),
                ),
              ),
              // SliverToBoxAdapter(child: UIHelper.verticalSpaceMedium()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: BoxedContainer(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Switch to full Screen",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            const Text(
                                "I gave it a border, but it would be nice to have rounded borders."),
                            UIHelper.verticalSpaceSmall(),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: (() => null),
                                  child: const Text("Read more"),
                                ),
                                UIHelper.horizontalSpaceMedium(),
                                TextButton(
                                  onPressed: (() => null),
                                  child: const Text("Dismiss"),
                                ),
                              ],
                            ),
                          ],
                        )),
                        Icon(
                          Iconsax.bank4,
                          size: 50.sp,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: UIHelper.verticalSpaceMedium(),
              ),
              SliverFixedExtentList(
                itemExtent: 55.h, // I'm forcing item heights
                delegate: SliverChildBuilderDelegate(childCount: 25,
                    (context, index) {
                  return ListTile(
                    leading: SizedBox(
                      // height: 45.h,
                      width: 70.w,
                      // margin: EdgeInsets.symmetric(horizontal: 16.0.w),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(6.0.sp),
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Color(randomColor[randomNumber(
                          //         min: 0, max: randomColor.length - 1)]),
                          //     border: Border.all(
                          //       width: 0.0.sp,
                          //       color: Color(randomColor[randomNumber(
                          //           min: 0, max: randomColor.length - 1)]),
                          //     ),
                          //   ),
                          //   child: Text(
                          //     "24",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .titleMedium!
                          //         .copyWith(fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          ClipOval(
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(randomColor[randomNumber(
                                  min: 0, max: randomColor.length - 1)]),
                              height: 35.0.sp,
                              width: 35.0.sp,
                              child: Text(
                                "24",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Sept"),
                              Text(
                                "2022",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    title: Text(
                      "Account Head",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
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
