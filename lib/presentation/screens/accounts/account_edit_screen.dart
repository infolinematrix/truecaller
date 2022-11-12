import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

import 'account_controller.dart';

class AccountEditScreen extends ConsumerWidget {
  const AccountEditScreen({super.key, required this.account});
  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    final parent = ref.watch(getAccountProvider(account.parent));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text("UPDATE ACCOUNT")),
      body: SafeArea(
        child: SingleChildScrollView(
            child: parent.when(
          error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (parentAccount) {
            return FormBuilder(
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
                              initialValue: parentAccount.name,
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
                                    initialValue: parentAccount.type,
                                    decoration: const InputDecoration(
                                        labelText: 'Type'),
                                  ),
                                ),
                                UIHelper.horizontalSpaceMedium(),
                                Expanded(
                                  child: FormBuilderDropdown(
                                    name: 'hasChild',
                                    style: inputTextStyle,
                                    isExpanded: false,
                                    itemHeight: null,
                                    initialValue: account.hasChild,
                                    dropdownColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    decoration: const InputDecoration(
                                      labelText: 'Has Child',
                                    ),
                                    items: yesNo
                                        .map((yn) => DropdownMenuItem<bool>(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              value: yn['key'] as bool,
                                              child: Text(
                                                  yn['value'].toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ))
                                        .toList(),
                                    onChanged: (val) {
                                      ref.read(hasChildProvider.state).state =
                                          val as bool;
                                    },
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
                              initialValue: account.name,
                              style: inputTextStyle,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration: const InputDecoration(
                                  labelText: 'Account Title'),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                          ref.watch(hasChildProvider) == false &&
                                  account.allowReceipt == false
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    UIHelper.verticalSpaceMedium(),
                                    SizedBox(
                                      height: inputHeight,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FormBuilderDropdown(
                                              name: 'hasBudget',
                                              style: inputTextStyle,
                                              isExpanded: false,
                                              itemHeight: null,
                                              initialValue:
                                                  ref.watch(hasChildProvider),
                                              dropdownColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              decoration: const InputDecoration(
                                                labelText: 'Has Budget?',
                                              ),
                                              items: yesNo
                                                  .map((yn) =>
                                                      DropdownMenuItem<bool>(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        value:
                                                            yn['key'] as bool,
                                                        child: Text(
                                                            yn['value']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                      ))
                                                  .toList(),
                                              onChanged: (val) {
                                                ref
                                                    .read(hasBudget.state)
                                                    .state = val as bool;
                                              },
                                            ),
                                          ),
                                          UIHelper.horizontalSpaceMedium(),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              name: 'budget',
                                              enabled: ref.watch(hasBudget),
                                              style: inputTextStyle,
                                              initialValue: "0.0",
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators
                                                    .required(),
                                              ]),
                                              decoration: const InputDecoration(
                                                  labelText: 'Monthly Budget'),
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                decimal: true,
                                                signed: false,
                                              ),
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
                                              initialValue:
                                                  ref.watch(hasOpeningBanlance),
                                              dropdownColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Has Opening Balance?',
                                              ),
                                              items: yesNo
                                                  .map((yn) =>
                                                      DropdownMenuItem<bool>(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        value:
                                                            yn['key'] as bool,
                                                        child: Text(
                                                            yn['value']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                      ))
                                                  .toList(),
                                              onChanged: (val) {
                                                ref
                                                    .read(hasOpeningBanlance
                                                        .state)
                                                    .state = val as bool;
                                              },
                                            ),
                                          ),
                                          UIHelper.horizontalSpaceMedium(),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              name: 'openingBalance',
                                              enabled:
                                                  ref.watch(hasOpeningBanlance),
                                              style: inputTextStyle,
                                              initialValue: account
                                                  .openingBalance
                                                  .toString(),
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators
                                                    .required(),
                                              ]),
                                              decoration: const InputDecoration(
                                                  labelText: 'Opening Balance'),
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                decimal: true,
                                                signed: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          UIHelper.verticalSpaceMedium(),
                          SizedBox(
                            height: inputHeight,
                            child: FormBuilderTextField(
                              name: 'description',
                              initialValue: account.description,
                              style: inputTextStyle,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.sentences,
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
                                    title: const Text('Allow Payment'),
                                    name: 'allowPayment',
                                    initialValue: account.allowPayment,
                                    decoration: checkBoxDecoration,
                                  ),
                                ),
                                // UIHelper.verticalSpaceMedium(),
                                SizedBox(
                                  // height: inputHeight,
                                  child: FormBuilderSwitch(
                                    title: const Text('Allow Receipt'),
                                    name: 'allowReceipt',
                                    initialValue: account.allowReceipt,
                                    decoration: checkBoxDecoration,
                                  ),
                                ),
                                SizedBox(
                                  child: FormBuilderSwitch(
                                    title: const Text('Allow Transfer'),
                                    name: 'allowTransfer',
                                    initialValue: account.allowTransfer,
                                    decoration: checkBoxDecoration,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceMedium(),
                          SizedBox(
                            height: inputHeight,
                            child: FormBuilderCheckbox(
                              name: 'isActive',
                              initialValue: account.isActive,
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
                            ),
                          ),
                          UIHelper.verticalSpaceExtraLarge(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ButtonDefault(
                              text: const Text("SUBMIT"),
                              onTap: () async {
                                if (formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  EasyLoading.show(status: 'Saving...');
                                  await ref
                                      .read(accountProvider(parentAccount.id)
                                          .notifier)
                                      .update(
                                          account: account,
                                          formData: formKey.currentState!.value)
                                      .then((value) {
                                    if (value == true) {
                                      EasyLoading.dismiss();
                                      EasyLoading.showSuccess("Successfull");
                                      GoRouter.of(context).pop();
                                    }
                                  });
                                } else {
                                  EasyLoading.dismiss();
                                  EasyLoading.showToast("Validation fail");
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
