import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/utils/functions.dart';

class AccountSearchScreen extends ConsumerWidget {
  const AccountSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              FormBuilder(
                key: formKey,
                child: SliverAppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  title: const Text('SEARCH'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(45.0.h),
                    child: Container(
                      height: 45.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Card(
                        elevation: .50,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          side: BorderSide(
                              width: .50,
                              color: Theme.of(context).disabledColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 0.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SlideInLeft(
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(Iconsax.search_normal)),

                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'searchText',
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  onChanged: (val) {},
                                ),
                              ),
                              //
                              SlideInRight(
                                  duration: const Duration(milliseconds: 300),
                                  child: Text("SEARCH",
                                      style:
                                          Theme.of(context).textTheme.caption)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: Color(randomColor[
                          randomNumber(min: 0, max: randomColor.length - 1)]),
                      height: 40.0.sp,
                      width: 40.0.sp,
                      child: Text(
                        "M",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  title: Text(
                    "Account name",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: const Text("Account Descripttion"),
                );
              }),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Card(
        //       child: SizedBox(
        //         height: 50.h,
        //         child: Padding(
        //           padding:
        //               EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 0.0.h),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               const Icon(Iconsax.search_normal),
        //               const Expanded(child: SizedBox.shrink()),
        //               Text("SEARCH",
        //                   style: Theme.of(context).textTheme.caption),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: ListView.builder(
        //         itemCount: 10,
        //         itemBuilder: (BuildContext context, int index) {
        //           return ListTile(
        //             dense: true,
        //             visualDensity:
        //                 const VisualDensity(horizontal: 0, vertical: -4),
        //             title: Text(
        //               "Account name",
        //               style: Theme.of(context).textTheme.bodyText1,
        //             ),
        //             subtitle: const Text("Account Descripttion"),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
