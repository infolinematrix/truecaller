import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/screens/home/home_screen.dart';

import 'presentation/screens/error.dart';
import 'presentation/widgets/index.dart';
import 'utils/functions.dart';
import 'utils/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      if (kReleaseMode) exit(1);
    };

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    // Transparent status bar
    // if (Platform.isAndroid) {
    //   SystemUiOverlayStyle systemUiOverlayStyle =
    //       const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // }
  }, (Object error, StackTrace stack) {
    ErrorPage(msg: error.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812 - 44 - 34),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   appBarTheme: const AppBarTheme(
          //     systemOverlayStyle: SystemUiOverlayStyle.light,
          //   ),
          // ),
          title: 'Flutter Demo',
          // theme: ThemeData(primarySwatch: Colors.blue),
          home: HomeScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60.h, // Set this height
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 40.h),
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Card(
            color: Theme.of(context).bottomAppBarColor,
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
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Iconsax.home_1), // icon
                Text(
                  "Home",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Iconsax.chart_square), // icon
                Text(
                  "Report",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Iconsax.empty_wallet_change), // icon
                Text(
                  "Accounts",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Iconsax.personalcard), // icon
                Text(
                  "Settings",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIHelper.verticalSpaceMedium(),
              SizedBox(
                height: 75.h,
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
                            height: 40.h,
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Text(
                                "My Account Book",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(),
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceExtraSmall(),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
              UIHelper.verticalSpaceMedium(),
              Padding(
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
              SizedBox(
                height: 800,
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Container(
                          height: 40.h,
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
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
