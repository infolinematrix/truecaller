import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/container_block.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

class TransferScreen extends ConsumerWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text("TRANSFER"),
      ),
      body: FormBuilder(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: ListView(shrinkWrap: true, children: [
            BoxedContainer(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "TRANSFER ENTRY",
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
                ],
              ),
            ),
            UIHelper.verticalSpaceLarge(),
            BoxedContainer(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "DEBIT HEAD",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  SizedBox(
                    height: inputHeight,
                    child: FormBuilderTextField(
                      name: 'name',
                      initialValue: "ABCD",
                      enabled: false,
                      style: inputTextStyle,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: const InputDecoration(labelText: 'Account'),
                    ),
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Text(
                    "CREDIT HEAD",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  SizedBox(
                    height: inputHeight,
                    child: FormBuilderTextField(
                      name: 'name',
                      initialValue: "ABCD",
                      enabled: false,
                      style: inputTextStyle,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: const InputDecoration(labelText: 'Account'),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            BoxedContainer(
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderTextField(
                              name: 'name',
                              initialValue: "ABCD",
                              enabled: false,
                              style: inputTextStyle,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration:
                                  const InputDecoration(labelText: 'Account'),
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceMedium(),
                        Expanded(
                          child: SizedBox(
                            height: inputHeight,
                            child: FormBuilderTextField(
                              name: 'type',
                              initialValue: "TRANSFER",
                              enabled: false,
                              style: inputTextStyle,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration:
                                  const InputDecoration(labelText: 'Account'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'description',
                        style: inputTextStyle,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
