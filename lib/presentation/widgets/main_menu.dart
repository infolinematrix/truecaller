import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/utils/index.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainMenuWidth = 80.0.w;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: SizedBox(
              height: 75.sp,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        GoRouter.of(context).push("/transaction/account-select",
                            extra: {'allowedTransactionType': 'PAYMENT'});
                      },
                      child: SizedBox(
                        width: mainMenuWidth,
                        child: Column(
                          children: [
                            Container(
                              width: 50.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: Color(randomColor[randomNumber(
                                    min: 0, max: randomColor.length - 1)]),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.export_1,
                                  // color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              "Payment",
                              style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        GoRouter.of(context).push("/transaction/account-select",
                            extra: {'allowedTransactionType': 'RECEIVE'});
                      },
                      child: SizedBox(
                        width: mainMenuWidth,
                        child: Column(
                          children: [
                            Container(
                              width: 50.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: Color(randomColor[randomNumber(
                                    min: 0, max: randomColor.length - 1)]),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.import_1,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              "Receive",
                              style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, "/account_select",
                            arguments: "RECEIPT");
                      },
                      child: SizedBox(
                        width: mainMenuWidth,
                        child: Column(
                          children: [
                            Container(
                              width: 50.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: Color(randomColor[randomNumber(
                                    min: 0, max: randomColor.length - 1)]),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.empty_wallet_change,
                                  // color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              "Transfer",
                              style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        GoRouter.of(context).pushNamed('HELPS');
                      },
                      child: SizedBox(
                        width: mainMenuWidth,
                        child: Column(
                          children: [
                            Container(
                              width: 50.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: Color(randomColor[randomNumber(
                                    min: 0, max: randomColor.length - 1)]),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.message_question,
                                  // color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              "Help",
                              style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        GoRouter.of(context).push('/groups');
                      },
                      child: SizedBox(
                        width: mainMenuWidth,
                        child: Column(
                          children: [
                            Container(
                              width: 50.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: Color(randomColor[randomNumber(
                                    min: 0, max: randomColor.length - 1)]),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.import_1,
                                  // color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              "Accounts",
                              style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // FadeInDown(
                  //   duration: const Duration(milliseconds: 200),
                  //   child: AspectRatio(
                  //     aspectRatio: 1,
                  //     child: GestureDetector(
                  //       onTap: () async {
                  //         Navigator.pushNamed(context, "/account_select",
                  //             arguments: "PAYMENT");
                  //       },
                  //       child: Column(
                  //         children: [
                  //           Container(
                  //             width: 100.sp,
                  //             height: 40.sp,
                  //             decoration: BoxDecoration(
                  //               color: Theme.of(context).highlightColor,
                  //               borderRadius: BorderRadius.circular(10.sp),
                  //             ),
                  //             child: Center(
                  //               child: Icon(
                  //                 Iconsax.export_1,
                  //                 // color: Colors.white,
                  //                 size: 24.sp,
                  //               ),
                  //             ),
                  //           ),
                  //           UIHelper.verticalSpaceSmall(),
                  //           Text(
                  //             "Payment",
                  //             style: TextStyle(
                  //                 // color: Colors.grey.shade800,
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // FadeInDown(
                  //   duration: const Duration(milliseconds: 200),
                  //   child: AspectRatio(
                  //     aspectRatio: 1,
                  //     child: GestureDetector(
                  //       onTap: () async {
                  //         Navigator.pushNamed(context, "/account_select",
                  //             arguments: "PAYMENT");
                  //       },
                  //       child: Column(
                  //         children: [
                  //           Container(
                  //             width: 100.sp,
                  //             height: 40.sp,
                  //             decoration: BoxDecoration(
                  //               color: Theme.of(context).highlightColor,
                  //               borderRadius: BorderRadius.circular(10.sp),
                  //             ),
                  //             child: Center(
                  //               child: Icon(
                  //                 Iconsax.export_1,
                  //                 // color: Colors.white,
                  //                 size: 24.sp,
                  //               ),
                  //             ),
                  //           ),
                  //           UIHelper.verticalSpaceSmall(),
                  //           Text(
                  //             "Payment",
                  //             style: TextStyle(
                  //                 // color: Colors.grey.shade800,
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // FadeInDown(
                  //   duration: const Duration(milliseconds: 200),
                  //   child: AspectRatio(
                  //     aspectRatio: 1,
                  //     child: GestureDetector(
                  //       onTap: () async {
                  //         Navigator.pushNamed(context, "/transfer");
                  //       },
                  //       child: Column(
                  //         children: [
                  //           Container(
                  //             width: 100.sp,
                  //             height: 40.sp,
                  //             decoration: BoxDecoration(
                  //               color: Theme.of(context).highlightColor,
                  //               borderRadius: BorderRadius.circular(10.sp),
                  //             ),
                  //             child: Center(
                  //               child: Icon(
                  //                 Iconsax.empty_wallet_change,
                  //                 // color: Colors.white,
                  //                 size: 24.sp,
                  //               ),
                  //             ),
                  //           ),
                  //           UIHelper.verticalSpaceSmall(),
                  //           Text(
                  //             "Transfer",
                  //             style: TextStyle(
                  //                 // color: Colors.grey.shade800,
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // FadeInDown(
                  //   duration: const Duration(milliseconds: 200),
                  //   child: AspectRatio(
                  //     aspectRatio: 1,
                  //     child: GestureDetector(
                  //       onTap: () async {},
                  //       child: Column(
                  //         children: [
                  //           Container(
                  //             width: 100.sp,
                  //             height: 40.sp,
                  //             decoration: BoxDecoration(
                  //               color: Theme.of(context).highlightColor,
                  //               borderRadius: BorderRadius.circular(10.sp),
                  //             ),
                  //             child: Center(
                  //               child: Icon(
                  //                 Iconsax.message_question,
                  //                 // color: Colors.white,
                  //                 size: 24.sp,
                  //               ),
                  //             ),
                  //           ),
                  //           UIHelper.verticalSpaceSmall(),
                  //           Text(
                  //             "Help",
                  //             style: TextStyle(
                  //                 // color: Colors.grey.shade800,
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
