import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/home/home_controller.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';
import 'package:intl/intl.dart';
import 'transaction_controller.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.account});

  final AccountsModel account;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text("PAYMENT"),
      ),
      body: FormBuilder(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            account.isActive == false
                ? BoxedContainer(
                    color: Theme.of(context).highlightColor,
                    content: const Text(
                      "Account is Inactive, you can't make any transaction.",
                    ),
                  )
                : account.allowPayment == false
                    ? BoxedContainer(
                        color: Theme.of(context).highlightColor,
                        content: const Text(
                          "Payment not allowed to this account, you can't make any transaction.",
                        ),
                      )
                    : BoxedContainer(
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "PAYMENT ENTRY",
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
                                initialValue: account.name.trim(),
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
                            SizedBox(
                              height: inputHeight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FormBuilderDateTimePicker(
                                      name: 'date',
                                      style: inputTextStyle,
                                      format: DateFormat('dd-MM-yyyy'),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      initialValue: DateTime.now(),
                                      inputType: InputType.date,
                                      decoration: const InputDecoration(
                                        labelText: 'Date',
                                        suffixIcon: Icon(Iconsax.calendar),
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceMedium(),
                                  Expanded(
                                    child: FormBuilderTextField(
                                      name: 'amount',
                                      style: inputTextStyle,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      decoration: const InputDecoration(
                                          labelText: 'Amount'),
                                      textInputAction: TextInputAction.next,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: false,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                                      ],
                                      // onChanged: (value) =>
                                      //     double.parse(value.toString())
                                      //         .toDouble(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpaceMedium(),
                            Consumer(builder: (context, ref, child) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: inputHeight,
                                      child: FormBuilderDropdown(
                                        name: 'mode',
                                        style: inputTextStyle,
                                        initialValue:
                                            ref.watch(txnModeProvider),
                                        isExpanded: false,
                                        itemHeight: null,
                                        decoration: const InputDecoration(
                                          labelText: 'Mode',
                                        ),
                                        onChanged: (value) {
                                          ref
                                              .read(txnModeProvider.state)
                                              .update(
                                                  (state) => value.toString());
                                        },
                                        items: txnMode
                                            .map(
                                              (mode) => DropdownMenuItem(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                value: mode,
                                                child: Text(
                                                  mode,
                                                  style:
                                                      inputTextStyle.copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceMedium(),
                                  Expanded(
                                    child: Container(
                                      height: inputHeight,
                                      color: Theme.of(context).highlightColor,
                                      child: Center(
                                        child: Text(
                                          ref.watch(txnModeProvider) == 'BANK'
                                              ? 'By Bank'
                                              : 'By Cash',
                                          style: inputTextStyle,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                            Consumer(builder: (context, ref, child) {
                              final banks = ref.watch(banksProvider);
                              return ref.watch(txnModeProvider) == 'BANK'
                                  ? Column(
                                      children: [
                                        UIHelper.verticalSpaceMedium(),
                                        banks.when(
                                          error: (error, stackTrace) =>
                                              const Text(
                                                  "Something went wring"),
                                          loading: () => const Text("Wait.."),
                                          data: (data) {
                                            return data.isNotEmpty
                                                ? SizedBox(
                                                    height: inputHeight,
                                                    child: FormBuilderDropdown(
                                                      name: 'bank_account',
                                                      style: inputTextStyle,
                                                      isExpanded: false,
                                                      itemHeight: null,
                                                      initialValue: data[0].id,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Bank Account',
                                                      ),
                                                      items: data
                                                          .map((item) =>
                                                              DropdownMenuItem(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .centerStart,
                                                                value: item.id,
                                                                child: Text(
                                                                  item.name,
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: inputHeight,
                                                    child: Text(
                                                        "No bank account found",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .error)),
                                                  );
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink();
                            }),
                            UIHelper.verticalSpaceMedium(),
                            SizedBox(
                              height: inputHeight,
                              child: FormBuilderTextField(
                                name: 'description',
                                style: inputTextStyle,
                                decoration: const InputDecoration(
                                    labelText: 'Description'),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ),
                            UIHelper.verticalSpaceExtraLarge(),
                            Consumer(
                              builder: (context, ref, child) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: ButtonDefault(
                                    text: const Text("SUBMIT"),
                                    onTap: () async {
                                      if (formKey.currentState
                                              ?.saveAndValidate() ??
                                          false) {
                                        EasyLoading.show(status: "Wait");

                                        final data = {
                                          'account': account.id,
                                          ...formKey.currentState!.value
                                        };

                                        await ref
                                            .read(doPayment(data).future)
                                            .then((value) {
                                          if (value == true) {
                                            EasyLoading.showSuccess(
                                                "Successful");

                                            ref.refresh(homeDataProvider);

                                            GoRouter.of(context).pop();
                                            GoRouter.of(context).pushNamed(
                                                'STATEMENT',
                                                extra: account);
                                          } else {
                                            EasyLoading.showToast(
                                                "Something went wrong!");
                                          }
                                        });
                                      } else {
                                        EasyLoading.showError(
                                            "Invalid Operation");
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );

    // body: SafeArea(
    //   child: Padding(
    //     padding: EdgeInsets.all(16.0.sp),
    //     child: FormBuilder(
    //       key: formKey,
    //       child: account.isActive == false
    //           ? BoxedContainer(
    //               color: Theme.of(context).highlightColor,
    //               content: const Text(
    //                 "Account is Inactive, you can't make any transaction.",
    //               ),
    //             )
    //           : account.allowPayment == false
    //               ? BoxedContainer(
    //                   color: Theme.of(context).highlightColor,
    //                   content: const Text(
    //                     "Payment not allowed to this account, you can't make any transaction.",
    //                   ),
    //                 )
    //               : BoxedContainer(
    //                   content: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Text(
    //                         "PAYMENT ENTRY",
    //                         style: Theme.of(context)
    //                             .textTheme
    //                             .caption!
    //                             .copyWith(fontWeight: FontWeight.bold),
    //                       ),
    //                       UIHelper.verticalSpaceSmall(),
    //                       Text(
    //                         "Application settings enables you to save state in the application using very little information.",
    //                         style:
    //                             Theme.of(context).textTheme.bodySmall,
    //                       ),
    //                       UIHelper.verticalSpaceLarge(),
    //                       SizedBox(
    //                         height: inputHeight,
    //                         child: FormBuilderTextField(
    //                           name: 'name',
    //                           initialValue: account.name.trim(),
    //                           enabled: false,
    //                           style: inputTextStyle,
    //                           validator: FormBuilderValidators.compose([
    //                             FormBuilderValidators.required(),
    //                           ]),
    //                           decoration: const InputDecoration(
    //                               labelText: 'Account'),
    //                         ),
    //                       ),
    //                       UIHelper.verticalSpaceMedium(),
    //                       SizedBox(
    //                         height: inputHeight,
    //                         child: Row(
    //                           children: [
    //                             Expanded(
    //                               child: FormBuilderDateTimePicker(
    //                                 name: 'date',
    //                                 style: inputTextStyle,
    //                                 initialEntryMode:
    //                                     DatePickerEntryMode
    //                                         .calendarOnly,
    //                                 initialValue: DateTime.now(),
    //                                 inputType: InputType.date,
    //                                 decoration: const InputDecoration(
    //                                   labelText: 'Date',
    //                                   suffixIcon:
    //                                       Icon(Iconsax.calendar),
    //                                 ),
    //                               ),
    //                             ),
    //                             UIHelper.horizontalSpaceMedium(),
    //                             Expanded(
    //                               child: FormBuilderTextField(
    //                                 name: 'amount',
    //                                 style: inputTextStyle,
    //                                 validator:
    //                                     FormBuilderValidators.compose([
    //                                   FormBuilderValidators.required(),
    //                                 ]),
    //                                 decoration: const InputDecoration(
    //                                     labelText: 'Amount'),
    //                                 textInputAction:
    //                                     TextInputAction.next,
    //                                 keyboardType: const TextInputType
    //                                     .numberWithOptions(
    //                                   decimal: true,
    //                                   signed: false,
    //                                 ),
    //                                 inputFormatters: [
    //                                   FilteringTextInputFormatter.allow(
    //                                       RegExp(r'^(\d+)?\.?\d{0,2}'))
    //                                 ],
    //                                 onChanged: (value) =>
    //                                     double.parse(value.toString())
    //                                         .toDouble(),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       UIHelper.verticalSpaceMedium(),
    //                       Consumer(builder: (context, ref, child) {
    //                         return Row(
    //                           children: [
    //                             Expanded(
    //                               child: SizedBox(
    //                                 height: inputHeight,
    //                                 child: FormBuilderDropdown(
    //                                   name: 'mode',
    //                                   style: inputTextStyle,
    //                                   initialValue:
    //                                       ref.watch(txnModeProvider),
    //                                   isExpanded: false,
    //                                   itemHeight: null,
    //                                   decoration: const InputDecoration(
    //                                     labelText: 'Mode',
    //                                   ),
    //                                   onChanged: (value) {
    //                                     ref
    //                                         .read(txnModeProvider.state)
    //                                         .update((state) =>
    //                                             value.toString());
    //                                   },
    //                                   items: txnMode
    //                                       .map(
    //                                         (mode) => DropdownMenuItem(
    //                                           alignment:
    //                                               AlignmentDirectional
    //                                                   .centerStart,
    //                                           value: mode,
    //                                           child: Text(
    //                                             mode,
    //                                             style: inputTextStyle
    //                                                 .copyWith(
    //                                                     color: Theme.of(
    //                                                             context)
    //                                                         .primaryColor),
    //                                           ),
    //                                         ),
    //                                       )
    //                                       .toList(),
    //                                 ),
    //                               ),
    //                             ),
    //                             UIHelper.horizontalSpaceMedium(),
    //                             Expanded(
    //                               child: Container(
    //                                 height: inputHeight,
    //                                 color: Theme.of(context)
    //                                     .highlightColor,
    //                                 child: Center(
    //                                   child: Text(
    //                                     ref.watch(txnModeProvider) ==
    //                                             'BANK'
    //                                         ? 'By Bank'
    //                                         : 'By Cash',
    //                                     style: inputTextStyle,
    //                                   ),
    //                                 ),
    //                               ),
    //                             )
    //                           ],
    //                         );
    //                       }),
    //                       Consumer(builder: (context, ref, child) {
    //                         final banks = ref.watch(banksProvider);
    //                         return ref.watch(txnModeProvider) == 'BANK'
    //                             ? Column(
    //                                 children: [
    //                                   UIHelper.verticalSpaceMedium(),
    //                                   banks.when(
    //                                     error: (error, stackTrace) =>
    //                                         const Text(
    //                                             "Something went wring"),
    //                                     loading: () =>
    //                                         const Text("Wait.."),
    //                                     data: (data) {
    //                                       return data.isNotEmpty
    //                                           ? SizedBox(
    //                                               height: inputHeight,
    //                                               child:
    //                                                   FormBuilderDropdown(
    //                                                 name:
    //                                                     'bank_account',
    //                                                 style:
    //                                                     inputTextStyle,
    //                                                 isExpanded: false,
    //                                                 itemHeight: null,
    //                                                 initialValue:
    //                                                     data[0].id,
    //                                                 decoration:
    //                                                     const InputDecoration(
    //                                                   labelText:
    //                                                       'Bank Account',
    //                                                 ),
    //                                                 items: data
    //                                                     .map((item) =>
    //                                                         DropdownMenuItem(
    //                                                           alignment:
    //                                                               AlignmentDirectional
    //                                                                   .centerStart,
    //                                                           value: item
    //                                                               .id,
    //                                                           child:
    //                                                               Text(
    //                                                             item.name,
    //                                                             style: TextStyle(
    //                                                                 color:
    //                                                                     Theme.of(context).primaryColor),
    //                                                           ),
    //                                                         ))
    //                                                     .toList(),
    //                                               ),
    //                                             )
    //                                           : SizedBox(
    //                                               height: inputHeight,
    //                                               child: Text(
    //                                                   "No bank account found",
    //                                                   style: TextStyle(
    //                                                       color: Theme.of(
    //                                                               context)
    //                                                           .errorColor)),
    //                                             );
    //                                     },
    //                                   ),
    //                                 ],
    //                               )
    //                             : const SizedBox.shrink();
    //                       }),
    //                       UIHelper.verticalSpaceMedium(),
    //                       SizedBox(
    //                         height: inputHeight,
    //                         child: FormBuilderTextField(
    //                           name: 'description',
    //                           style: inputTextStyle,
    //                           decoration: const InputDecoration(
    //                               labelText: 'Description'),
    //                         ),
    //                       ),
    //                       UIHelper.verticalSpaceExtraLarge(),
    //                       Consumer(
    //                         builder: (context, ref, child) {
    //                           return Align(
    //                             alignment: Alignment.centerRight,
    //                             child: ButtonDefault(
    //                               text: const Text("SUBMIT"),
    //                               onTap: () async {
    //                                 if (formKey.currentState
    //                                         ?.saveAndValidate() ??
    //                                     false) {
    //                                   // EasyLoading.show(status: "Wait");

    //                                   final data = {
    //                                     'account': account.id,
    //                                     ...formKey.currentState!.value
    //                                   };

    //                                   await ref
    //                                       .read(doPayment(data).future)
    //                                       .then((value) {
    //                                     if (value == true) {
    //                                       EasyLoading.showSuccess(
    //                                           "Successful");
    //                                     } else {
    //                                       EasyLoading.showToast(
    //                                           "Something went wrong!");
    //                                     }
    //                                   });
    //                                 } else {
    //                                   EasyLoading.showError(
    //                                       "Invalid Operation");
    //                                 }
    //                               },
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //     ),
    //   ),
    // ),
    // )
  }
}
