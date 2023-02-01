import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/application/constants.dart';
import 'package:truecaller/utils/index.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 80.h,
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Center(
                  child: Container(
                    width: 65.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0.h),
                          child: ClipOval(
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(randomColor[randomNumber(
                                  min: 0, max: randomColor.length - 1)]),
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
                        ),
                        UIHelper.verticalSpaceExtraSmall(),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Text(
                              "12,650",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Text(
                              "12 min ago",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 15.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.0.sp, vertical: 2.0.sp),
                      child: Icon(
                        Iconsax.export,
                        size: 16.0.sp,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            );
            // return SizedBox(
            //   width: 90.w,
            //   child: Container(
            //     margin: EdgeInsets.only(left: 8.0.w),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Stack(
            //           children: [
            //             ClipOval(
            //               child: Container(
            //                 alignment: Alignment.center,
            //                 color: Color(randomColor[randomNumber(
            //                     min: 0, max: randomColor.length - 1)]),
            //                 height: 40.0.sp,
            //                 width: 40.0.sp,
            //                 child: Text(
            //                   "M",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .titleLarge!
            //                       .copyWith(fontWeight: FontWeight.w500),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               top: 0,
            //               right: 0,
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(5.0),
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 4.0.sp, vertical: 2.0.sp),
            //                   color: const Color(0xffF8742C),
            //                   child: Align(
            //                     alignment: Alignment.center,
            //                     child: Text(
            //                       "1223",
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .subtitle2!
            //                           .copyWith(
            //                               fontSize: 8.0.sp,
            //                               fontWeight: FontWeight.bold,
            //                               color: Theme.of(context).canvasColor),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         UIHelper.verticalSpaceSmall(),
            //         Flexible(
            //           child: Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            //             child: Text(
            //               "My Account Book",
            //               maxLines: 1,
            //               overflow: TextOverflow.clip,
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyText2!
            //                   .copyWith(fontWeight: FontWeight.w500),
            //             ),
            //           ),
            //         ),
            //         UIHelper.verticalSpaceExtraSmall(),
            //         Flexible(
            //           child: Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            //             child: Text(
            //               "12 min ago",
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //               style:
            //                   Theme.of(context).textTheme.bodySmall!.copyWith(),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
