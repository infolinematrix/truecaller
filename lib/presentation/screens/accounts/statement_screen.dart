import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/presentation/screens/accounts/account_statement_controller.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/functions.dart';
import 'package:truecaller/utils/ui_helper.dart';
import 'package:intl/intl.dart';

class AccountStatementScreen extends ConsumerWidget {
  const AccountStatementScreen(
      {super.key, required this.name, required this.id});
  final int id;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text("ACCOUNT NAME"),
        actions: [
          IconButton(
              onPressed: () {
                ref.watch(isFilterProvider.state).state == true
                    ? ref.watch(isFilterProvider.state).update((state) => false)
                    : ref.watch(isFilterProvider.state).update((state) => true);
              },
              icon: const Icon(
                Iconsax.filter_square,
                size: 28,
              )),
          UIHelper.horizontalSpaceMedium()
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ref.watch(isFilterProvider.state).state == true
              ? FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0.sp),
                        child: SizedBox(
                          height: inputHeight,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child: FormBuilderDateRangePicker(
                                  name: 'date_range',
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime(2030),
                                  format: DateFormat('yyyy-MM-dd'),
                                  // onChanged: _onChanged,
                                  decoration: const InputDecoration(
                                    labelText: 'Date Range',
                                    iconColor: Colors.red,
                                    suffixIcon: Icon(Iconsax.calendar),
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpaceSmall(),
                              Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: inputHeight,
                                    child: ButtonDefault(
                                        color: Color(randomColor[randomNumber(
                                            min: 5,
                                            max: randomColor.length - 1)]),
                                        onTap: () {},
                                        text: Icon(
                                          Iconsax.search_favorite,
                                          size: 16.0.sp,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0.w, top: 4.h),
                        child: Text(
                          "28TH, OCTOBER, 2002",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        // dense: true,
                        // contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leading: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: Color(randomColor[randomNumber(
                                min: 0, max: randomColor.length - 1)]),
                            height: 36.0.sp,
                            width: 36.0.sp,
                            child: Text(
                              "M",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        title: const Text(
                          "To Account head",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Iconsax.export_3, //import_2
                                  size: 15.sp, color: Colors.red,
                                ),
                                UIHelper.horizontalSpaceExtraSmall(),
                                const Text("Payment description"),
                              ],
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "12,650",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Cash",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
