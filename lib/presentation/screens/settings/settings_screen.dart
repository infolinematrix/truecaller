import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/ui_helper.dart';

import '../../widgets/index.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text("SETTINGS"),
      ),
      bottomNavigationBar: const BottomNavigation(index: 3),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: FormBuilder(
            key: formKey,
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
                      SizedBox(
                        height: inputHeight,
                        child: FormBuilderTextField(
                          name: 'name',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium(),
                      SizedBox(
                        height: inputHeight,
                        child: Row(
                          children: [
                            Expanded(
                              child: FormBuilderDropdown<String>(
                                name: 'dateFormat',
                                isExpanded: false,
                                itemHeight: null,
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                decoration: const InputDecoration(
                                    labelText: 'Date Format'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                items: ['Male', 'Female']
                                    .map((gender) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: gender,
                                          child: Text(gender,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                        ))
                                    .toList(),
                              ),
                            ),
                            UIHelper.horizontalSpaceMedium(),
                            Expanded(
                              child: FormBuilderDropdown<String>(
                                name: 'currencyFormat',
                                isExpanded: false,
                                itemHeight: null,
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                decoration: const InputDecoration(
                                    labelText: 'Currency Format'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                items: ['#,##,##0.00', '###,##0.00']
                                    .map((gender) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: gender,
                                          child: Text(gender,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500)),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'cashInHand',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                decoration: const InputDecoration(
                                    labelText: 'Cash in Hand'),
                              ),
                            ),
                            UIHelper.horizontalSpaceMedium(),
                            Expanded(
                              child: FormBuilderDropdown(
                                name: 'hasBank',
                                isExpanded: false,
                                itemHeight: null,
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                decoration: const InputDecoration(
                                    label: Text("Bank Account")),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                items: hasBankAccount
                                    .map((bank) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: bank['code'],
                                          child: Text(bank['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500)),
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
                        child: FormBuilderCheckbox(
                          name: 'accept_terms',
                          initialValue: false,
                          decoration: checkBoxDecoration,
                          title: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I have read and agree to the ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
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
                            onTap: () async {
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                debugPrint(
                                    formKey.currentState?.value.toString());
                              } else {
                                debugPrint(
                                    formKey.currentState?.value.toString());
                                debugPrint('validation failed');
                              }
                            },
                            text: const Text("SAVE & CONTINUE")),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
