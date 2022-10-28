import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/screens/settings/bank_account_controller.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

class SettingsBankAccountScreen extends ConsumerWidget {
  const SettingsBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Account"),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              BoxedContainer(
                  content: Column(
                children: [
                  Text(
                    "BANK ACCOUNT",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(
                    "Application settings enables you to save state in the application using very little information.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  UIHelper.verticalSpaceLarge(),
                  SizedBox(
                    height: inputHeight,
                    child: FormBuilderTextField(
                      name: 'name',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: const InputDecoration(labelText: 'Bank Name'),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  SizedBox(
                    height: inputHeight,
                    child: FormBuilderTextField(
                      name: 'description',
                      style: inputTextStyle,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  SizedBox(
                    height: inputHeight,
                    child: Row(
                      children: [
                        Expanded(
                          child: FormBuilderDropdown(
                            name: 'hasOpeningBalance',
                            style: inputTextStyle,
                            isExpanded: false,
                            itemHeight: null,
                            initialValue: ref.watch(hasOpeningBanlance),
                            dropdownColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            decoration: const InputDecoration(
                              labelText: 'Has Opening Balance?',
                            ),
                            items: yesNo
                                .map((yn) => DropdownMenuItem<bool>(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      value: yn['key'] as bool,
                                      child: Text(yn['value'].toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              ref.read(hasOpeningBanlance.state).state =
                                  val as bool;
                            },
                          ),
                        ),
                        UIHelper.horizontalSpaceMedium(),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'openingBalance',
                            enabled: ref.watch(hasOpeningBanlance),
                            style: inputTextStyle,
                            initialValue: "0.0",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: const InputDecoration(
                                labelText: 'Opening Balance'),
                            textInputAction: TextInputAction.next,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Text(
                    "SETTINGS",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(
                    "Application settings enables you to save state in the application using very little information.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          // height: inputHeight,
                          child: FormBuilderSwitch(
                            title: const Text('Allow Payment entry'),
                            name: 'allowPayment',
                            // initialValue: parent.allowPayment,
                            decoration: checkBoxDecoration,
                          ),
                        ),
                        // UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          // height: inputHeight,
                          child: FormBuilderSwitch(
                            title: const Text('Allow Receipt entry'),
                            name: 'allowReceipt',
                            // initialValue: parent.allowReceipt,
                            decoration: checkBoxDecoration,
                          ),
                        ),
                        SizedBox(
                          child: FormBuilderSwitch(
                            title: const Text('Allow Transfer entry'),
                            name: 'allowTransfer',
                            // initialValue: parent.allowTransfer,
                            decoration: checkBoxDecoration,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                ],
              )),
            ],
          ),
        ),
      )),
    );
  }
}
