import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

class SettingsBankAccountScreen extends ConsumerWidget {
  const SettingsBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("BANK ACCOUNT"),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                BoxedContainer(
                    content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "BANK ACCOUNT",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(
                      "Application settings enables you to save state in the application using very little information.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    UIHelper.verticalSpaceLarge(),
                    const Divider(),
                    UIHelper.verticalSpaceMedium(),
                  ],
                )),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
