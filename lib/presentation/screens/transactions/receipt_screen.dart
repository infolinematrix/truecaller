import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/container_block.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

class ReceiptScreen extends ConsumerWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text("RECEIPT")),
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
                          "RECEIPT ENTRY",
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
                            enabled: false,
                            style: inputTextStyle,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration:
                                const InputDecoration(labelText: 'Account'),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Row(
                          children: [
                            Expanded(
                              child: FormBuilderDateTimePicker(
                                name: 'date',
                                style: inputTextStyle,
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                initialValue: DateTime.now(),
                                inputType: InputType.date,
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  suffixIcon: Icon(Iconsax.calendar),
                                ),
                                // initialTime:
                                //     const TimeOfDay(hour: 8, minute: 0),
                                locale: const Locale.fromSubtags(
                                    languageCode: 'fr'),
                              ),
                            ),
                            UIHelper.horizontalSpaceMedium(),
                            Expanded(
                                child: SizedBox(
                              height: inputHeight,
                              child: FormBuilderDropdown(
                                name: 'mode',
                                style: inputTextStyle,
                                isExpanded: false,
                                itemHeight: null,
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                decoration: const InputDecoration(
                                  labelText: 'Mode',
                                ),
                                items: ['CASH', 'BANK']
                                    .map((gender) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: gender,
                                          child: Text(gender,
                                              style: inputTextStyle),
                                        ))
                                    .toList(),
                              ),
                            )),
                          ],
                        ),
                        Column(
                          children: [
                            UIHelper.verticalSpaceMedium(),
                            SizedBox(
                              height: inputHeight,
                              child: FormBuilderDropdown(
                                name: 'bank_account',
                                style: inputTextStyle,
                                isExpanded: false,
                                itemHeight: null,
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                decoration: const InputDecoration(
                                  labelText: 'Bank Account',
                                ),
                                items: ['CASH', 'BANK']
                                    .map((gender) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          value: gender,
                                          child: Text(gender,
                                              style: inputTextStyle),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'amount',
                                  enabled: true,
                                  style: inputTextStyle,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Amount'),
                                ),
                              ),
                              UIHelper.horizontalSpaceMedium(),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'Scroll',
                                  enabled: false,
                                  style: inputTextStyle,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Scroll'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: FormBuilderTextField(
                            name: 'description',
                            enabled: false,
                            style: inputTextStyle,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                          ),
                        ),
                        UIHelper.verticalSpaceExtraLarge(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
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
                            child: const Text("MAKE PAYMENT"),
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
