import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/bottom_navigation.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/ui_helper.dart';

import '../../widgets/index.dart';
import 'settings_controller.dart';

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
                          decoration:
                              const InputDecoration(labelText: 'Your Name'),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
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
                                items: dateFormat
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
                              child: FormBuilderDropdown(
                                name: 'currency',
                                isExpanded: false,
                                itemHeight: null,
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                decoration: const InputDecoration(
                                    labelText: 'Currency'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                items: currencies
                                    .map((currencie) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: currencie['code'],
                                          child: Text(currencie['name'],
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
                                textInputAction: TextInputAction.next,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: false,
                                ),
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
                                EasyLoading.show(status: 'Wait...');
                                await ref
                                    .watch(createSettings(formKey.currentState
                                            ?.value as Map<String, dynamic>)
                                        .future)
                                    .then((value) {
                                  if (value == true) {
                                    EasyLoading.showSuccess("Successful");

                                    if (formKey
                                            .currentState!.value['hasBank'] ==
                                        'YES') {
                                      GoRouter.of(context).replaceNamed(
                                          'SETTINGS-BANK-ACCOUNT');
                                    } else {
                                      
                                      GoRouter.of(context).replaceNamed('HOME');
                                    }
                                  }
                                });
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
