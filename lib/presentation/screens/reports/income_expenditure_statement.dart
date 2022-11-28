import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/widgets/index.dart';
import 'package:truecaller/utils/index.dart';

class IncomeExpenditureStatement extends ConsumerWidget {
  const IncomeExpenditureStatement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).canvasColor,
            title: const Text("INCOME & EXPENDITURE"),
            pinned: true,
            floating: true,
            actions: [
              IconButton(
                icon: Icon(
                  Iconsax.add_square5,
                  size: 28.0.sp,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {},
              ),
              UIHelper.horizontalSpaceMedium()
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(45.0.h),
              child: const SearchBar(),
            ),
          ),
        ],
      ),
    );
  }
}
