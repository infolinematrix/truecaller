import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

class AccountCreateScreen extends ConsumerWidget {
  const AccountCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text("CREATE ACCOUNT")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BoxedContainer(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "ACCOUNT",
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
                            name: 'group',
                            enabled: false,
                            style: inputTextStyle,
                            initialValue: "Household Expenses",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration:
                                const InputDecoration(labelText: 'Group'),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'type',
                                  enabled: false,
                                  style: inputTextStyle,
                                  initialValue: "EXPENSES",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration:
                                      const InputDecoration(labelText: 'Type'),
                                ),
                              ),
                              UIHelper.horizontalSpaceMedium(),
                              Expanded(
                                child: FormBuilderDropdown(
                                  name: 'hasChild',
                                  style: inputTextStyle,
                                  isExpanded: false,
                                  itemHeight: null,
                                  initialValue: 'NO',
                                  dropdownColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  decoration: const InputDecoration(
                                    labelText: 'Has Child',
                                  ),
                                  items: ['YES', 'NO']
                                      .map((gender) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: gender,
                                            child: Text(gender,
                                                style: inputTextStyle.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: FormBuilderTextField(
                            name: 'name',
                            enabled: false,
                            style: inputTextStyle,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: const InputDecoration(
                                labelText: 'Account Title'),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: Row(
                            children: [
                              Expanded(
                                child: FormBuilderDropdown(
                                  name: 'limitedBudget',
                                  style: inputTextStyle,
                                  isExpanded: false,
                                  itemHeight: null,
                                  initialValue: 'YES',
                                  dropdownColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  decoration: const InputDecoration(
                                    labelText: 'Has Budget?',
                                  ),
                                  items: ['YES', 'NO']
                                      .map((gender) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: gender,
                                            child: Text(gender,
                                                style: inputTextStyle.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ))
                                      .toList(),
                                ),
                              ),
                              UIHelper.horizontalSpaceMedium(),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'budget',
                                  enabled: false,
                                  style: inputTextStyle,
                                  initialValue: "120.0",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Monthly Budget'),
                                ),
                              ),
                            ],
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
                                  initialValue: 'YES',
                                  dropdownColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  decoration: const InputDecoration(
                                    labelText: 'Has Opening Balance?',
                                  ),
                                  items: ['YES', 'NO']
                                      .map((gender) => DropdownMenuItem(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            value: gender,
                                            child: Text(gender,
                                                style: inputTextStyle.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ))
                                      .toList(),
                                ),
                              ),
                              UIHelper.horizontalSpaceMedium(),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'openingBalance',
                                  enabled: false,
                                  style: inputTextStyle,
                                  initialValue: "120.0",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Opening Balance'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceLarge(),
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
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
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
                                  name: 'accept_terms_switch',
                                  initialValue: true,
                                  decoration: checkBoxDecoration,
                                  // onChanged: _onChanged,
                                ),
                              ),
                              SizedBox(
                                // height: inputHeight,
                                child: FormBuilderSwitch(
                                  title: const Text('Allow Receipt entry'),
                                  name: 'accept_terms_switch',
                                  initialValue: true,
                                  decoration: checkBoxDecoration,
                                  // onChanged: _onChanged,
                                ),
                              ),
                              SizedBox(
                                child: FormBuilderSwitch(
                                  title: const Text('Allow Transfer entry'),
                                  name: 'accept_terms_switch',
                                  initialValue: true,
                                  decoration: checkBoxDecoration,
                                  // onChanged: _onChanged,
                                ),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: FormBuilderCheckbox(
                            name: 'accept_terms',
                            initialValue: false,
                            decoration: checkBoxDecoration,
                            title: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Yes, Account is active. ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        'Inactive account does not allow transaction',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            validator: FormBuilderValidators.equal(
                              true,
                              errorText: 'You must accept terms and conditions',
                            ),
                          ),
                        ),
                        UIHelper.verticalSpaceExtraLarge(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ButtonDefault(
                            text: const Text("SUBMIT"),
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
