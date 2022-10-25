import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/theme/app_theme.dart';
import 'package:truecaller/utils/index.dart';

class GroupCreateScreen extends ConsumerWidget {
  const GroupCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text("CREATE GROUP")),
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
                          "ACCOUNT GROUP",
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
                                const InputDecoration(labelText: 'Group Name'),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          height: inputHeight,
                          child: FormBuilderDropdown(
                            name: 'mode',
                            style: inputTextStyle,
                            isExpanded: false,
                            itemHeight: null,
                            dropdownColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            decoration: const InputDecoration(
                              labelText: 'Account Type',
                            ),
                            items: ['CASH', 'BANK']
                                .map(
                                  (gender) => DropdownMenuItem(
                                    alignment: AlignmentDirectional.centerStart,
                                    value: gender,
                                    child: Text(
                                      gender,
                                      style: inputTextStyle.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),

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
                        // UIHelper.verticalSpaceMedium(),
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
