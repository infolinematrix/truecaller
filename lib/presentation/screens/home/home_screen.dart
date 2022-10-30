import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/presentation/widgets/main_menu.dart';
import 'package:truecaller/utils/index.dart';

import 'components/app_aupdate.dart';
import 'components/app_bar.dart';
import 'components/month_summary.dart';
import 'components/recent_activity.dart';
import 'components/today_summary.dart';
import 'components/todays_transaction_widget.dart';
import 'home_controller.dart';

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
    final homeData = ref.watch(homeDataProvider);
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
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8.0.sp)),
                  ),
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(16.0.sp),
                        constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: ListTile(
                                  isThreeLine: true,
                                  leading: Container(
                                    width: 50.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: Color(randomColor[randomNumber(
                                          min: 0,
                                          max: randomColor.length - 1)]),
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Iconsax.import_1,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "PAYMENT",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text(
                                      "Make payment to party for for goods, or services provided by them."),
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {},
                                child: ListTile(
                                  isThreeLine: true,
                                  leading: Container(
                                    width: 50.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: Color(randomColor[randomNumber(
                                          min: 0,
                                          max: randomColor.length - 1)]),
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Iconsax.export_1,
                                        // color: Colors.white,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "RECEIVE",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text(
                                      "Receive money from party for for goods, or services provided by you."),
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {},
                                child: ListTile(
                                  isThreeLine: true,
                                  leading: Container(
                                    width: 50.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: Color(randomColor[randomNumber(
                                          min: 0,
                                          max: randomColor.length - 1)]),
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Iconsax.empty_wallet_change,
                                        // color: Colors.white,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "TRANSFER",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text(
                                      "Receive money from party for for goods, or services provided by you."),
                                ),
                              ),
                            ]),
                      ),
                    );
                  });
            },
            child: const Icon(Iconsax.wallet),
          ),
        ),
        drawer: const DrawerNavigation(),
        body: SafeArea(
          child: homeData.when(
            error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            data: (data) {
              return CustomScrollView(
                slivers: <Widget>[
                  const AppBarWidget(),
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

                  const RecentActivity(),

                  SliverToBoxAdapter(
                    child: UIHelper.verticalSpaceSmall(),
                  ),
                  const MainMenuWidget(),

                  //--Today Summary
                  TodaySummary(data: data.todayMonthSummary),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const Image(
                          image: AssetImage('assets/images/banner1.png'),
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: UIHelper.verticalSpaceSmall(),
                  ),
                  
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                      child: BoxedContainer(
                          content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                GoRouter.of(context).push(
                                    "/transaction/account-select",
                                    extra: {
                                      'allowedTransactionType': 'PAYMENT'
                                    });
                              },
                              child: const Text("PAYMENT")),
                          TextButton(
                              onPressed: () {
                                GoRouter.of(context).pushNamed("RECEIPT");
                              },
                              child: const Text("RECEIVE")),
                          TextButton(
                              onPressed: () {
                                GoRouter.of(context).pushNamed("TRANSFER");
                              },
                              child: const Text("TRANSFER")),
                          TextButton(
                              onPressed: () {
                                GoRouter.of(context)
                                    .pushNamed("ACCOUNTS/SEARCH");
                              },
                              child: const Text("HELP")),
                        ],
                      )),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: UIHelper.verticalSpaceMedium(),
                  ),
                  //--Update

                  const AppUpdate(),

                  //--Month Summary
                  MonthSummary(data: data.currentMonthSummary),

                  //--Accouns summary month
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0.w, vertical: 8.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "EXPENDITURE SUMMARY - APRIL. 2022",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Sample letter to announce the anniversary of your business",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  )),
                  SliverFixedExtentList(
                    itemExtent: 50.h,
                    delegate: SliverChildBuilderDelegate(
                        childCount: data.monthlyAccountWiseSummary.length,
                        (context, index) {
                      return ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        title: Text(
                          data.monthlyAccountWiseSummary[index]['account'].name,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        subtitle: Text(data
                            .monthlyAccountWiseSummary[index]['account']
                            .description),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10.0.h,
                              width: 100.w,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    color: Theme.of(context).disabledColor,
                                    width: MediaQuery.of(context).size.width,
                                    height: 4,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      color: Theme.of(context).hoverColor,
                                      width: data.monthlyAccountWiseSummary[
                                              index]['percetageUsed'] ??
                                          double.parse(data
                                                  .monthlyAccountWiseSummary[
                                                      index]['percetageUsed']
                                                  .toString())
                                              .toDouble()
                                              .w, // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
                                      height: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                                data.monthlyAccountWiseSummary[index]['balance']
                                    .toString(),
                                style: Theme.of(context).textTheme.subtitle2),
                            data.monthlyAccountWiseSummary[index]['account']
                                        .budget >
                                    0
                                ? Text(
                                    "Budget ${data.monthlyAccountWiseSummary[index]['account'].budget}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontStyle: FontStyle.italic),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0.w, vertical: 8.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "TRANSACTIONS OF THE DAY",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Sample letter to announce the anniversary of your business",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  )),
                  TodaysTransactionWidget(
                    txns: data.transactionsToday,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
