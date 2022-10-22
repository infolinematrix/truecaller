import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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
        body: SafeArea(
          child: CustomScrollView(
            // 3
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,
                expandedHeight: 65.h,
                stretch: true,
                flexibleSpace: Container(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Card(
                    child: SizedBox(
                      height: 60.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.menu),
                            Icon(Icons.search),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              SliverToBoxAdapter(
                child: UIHelper.verticalSpaceMedium(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 85.h,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 85.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 45.h,
                              width: 45.w,
                              margin: EdgeInsets.symmetric(horizontal: 16.0.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: randomOpaqueColor(),
                              ),
                              child: Center(
                                child: Text(
                                  "H",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
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
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: UIHelper.verticalSpaceMedium(),
              ),
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
                          Container(
                            padding: EdgeInsets.all(6.0.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: randomOpaqueColor(),
                              border: Border.all(
                                width: 0.0.sp,
                                color: randomOpaqueColor(),
                              ),
                            ),
                            child: Text(
                              "24",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
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
