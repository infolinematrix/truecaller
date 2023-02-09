import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/screens/settings/bank_account_controller.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

class SettingsBankAccountCreateScreen extends ConsumerWidget {
  const SettingsBankAccountCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("CREATE BANK ACCOUNT"),
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
                    SizedBox(
                      height: inputHeight,
                      child: FormBuilderTextField(
                        name: 'name',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration:
                            const InputDecoration(labelText: 'Bank Name'),
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
                              // initialValue: "0.0",
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration: const InputDecoration(
                                  labelText: 'Opening Balance'),
                              textInputAction: TextInputAction.next,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                      "NOTE",
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
                    UIHelper.verticalSpaceExtraLarge(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ButtonDefault(
                        text: const Text("SUBMIT"),
                        onTap: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            EasyLoading.show(status: 'Wait...');
                            await ref
                                .watch(createBankAccountProvider(
                                        formKey.currentState!.value)
                                    .future)
                                .then((value) {
                              if (value == true) {
                                EasyLoading.showSuccess("Successfull");
                                GoRouter.of(context).replaceNamed("HOME");
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
                )),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
