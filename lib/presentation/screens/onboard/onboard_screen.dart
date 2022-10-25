import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/utils/ui_helper.dart';

import 'onboard_controller.dart';

class OnboardScreen extends ConsumerWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(inttAppProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "FINDO",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text("A Penny Saved is a Penny Earned.",
                style: Theme.of(context).textTheme.bodyText2),
            UIHelper.verticalSpaceMedium(),
            // initialize.when(
            //   loading: () => SizedBox(
            //     width: ScreenUtil().screenWidth * .40,
            //     height: 2.0.h,
            //     child: LinearProgressIndicator(
            //       backgroundColor: Theme.of(context).primaryColor,
            //       color: Theme.of(context).highlightColor,
            //     ),
            //   ),
            //   error: (err, stack) => ErrorScreen(msg: err.toString()),
            //   data: (data) {
            //     // if (data.isLoggedin == false) {
            //     //   GoRouter.of(context).push('settings');
            //     // } else {
            //     //   GoRouter.of(context).push('home');
            //     // }

            //     // GoRouter.of(context).push('home');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
