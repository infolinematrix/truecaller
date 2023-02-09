import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/utils/index.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "WELCOME",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              UIHelper.verticalSpaceExtraSmall(),
              Text("AseztakTK Whole sale.",
                  style: Theme.of(context).textTheme.bodyMedium),
              UIHelper.verticalSpaceMedium(),
              SizedBox(
                width: 150.0.w,
                height: 2.0.h,
                child: const LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
