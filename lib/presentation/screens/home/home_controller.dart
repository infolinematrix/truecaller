import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/repositories/transaction_repository.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/utils/functions.dart';

final accountBox = store!.objStore.box<AccountsModel>();
final transactionBox = store!.objStore.box<TransactionsModel>();

class HomeDataModel {
  final List<TransactionsModel> transactionsToday;
  final List monthlyAccountWiseSummary;
  final List<Map<String, dynamic>> recentActivity;
  final Map<String, dynamic> currentMonthSummary;
  final Map<String, dynamic> todayMonthSummary;

  HomeDataModel(
      {required this.transactionsToday,
      required this.monthlyAccountWiseSummary,
      required this.currentMonthSummary,
      required this.todayMonthSummary,
      required this.recentActivity});
}

//=========== HOME PROVIDER ==================================================
final homeDataProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, AsyncValue<HomeDataModel>>(
        (ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<AsyncValue<HomeDataModel>> {
  final Ref ref;
  HomeNotifier(this.ref) : super(const AsyncValue<HomeDataModel>.loading()) {
    loadData();
  }

  loadData() async {
    final alldata = HomeDataModel(
      transactionsToday: await ref.read(todayTransactionsProvider),
      monthlyAccountWiseSummary:
          await ref.read(monthlyAccountWiseExpensesSummaryProvider),
      currentMonthSummary: ref.read(currentMonthSummaryProvider),
      todayMonthSummary: ref.read(currentDaySummaryProvider),
      recentActivity: ref.read(recentActivityProvider),
    );

    state = AsyncValue<HomeDataModel>.data(alldata);
  }
}

final todayTransactionsProvider =
    Provider.autoDispose<List<TransactionsModel>>((ref) {
  try {
    List<TransactionsModel> data = TransactionRepository().getAllToday();

    return data;
  } catch (e) {
    rethrow;
  }
});

final monthlyAccountWiseExpensesSummaryProvider =
    Provider.autoDispose<List>((ref) {
  try {
    var data = [];
    AccountRepository().all().then((accounts) async {
      for (AccountsModel account in accounts) {
        if (account.type != 'BANK' && account.type == 'EXPENSES') {
          var summary = await AccountRepository().accountSummary(
              accountNo: account.id,
              startDate: firstDayCurrentMonth,
              endtDate: lastDayCurrentMonth);

          double balance = 0;
          double percentageUsed = 0;

          if (account.budget! > 0) {
            balance = double.parse(summary['sum_debit'].toString()).toDouble();

            percentageUsed =
                (double.parse(summary['sum_debit'].toString()).toDouble() /
                        double.parse(account.budget.toString()).toDouble()) *
                    100;
          } else {
            balance = double.parse(summary['sum_debit'].toString()).toDouble();
          }

          if (balance > 0) {
            data.addAll([
              {
                'account': account,
                'balance': balance,
                'percetageUsed': percentageUsed
              }
            ]);
          }
        }
      }
    });

    return data;
  } catch (e) {
    rethrow;
  }
});

final currentMonthSummaryProvider =
    Provider.autoDispose<Map<String, dynamic>>((ref) {
  try {
    final List<TransactionsModel> data = TransactionRepository().getByDateRange(
        startDate: firstDayCurrentMonth, endtDate: lastDayCurrentMonth);

    double r = 0;
    double p = 0;

    for (var txn in data) {
      if (txn.txnType == 'PAYMENT') {
        p = p + txn.amountDr;
      }

      if (txn.txnType == 'RECEIVE') {
        r = r + txn.amountCr;
      }
    }

    double savP = 0;
    double exP = p * 100 / r;
    if (exP < 100) {
      savP = 100 - exP;
    }

    return {
      'income': r,
      'expenditure': p,
      'expensesPercentage': exP,
      'savingsPercentage': savP
    };
  } catch (e) {
    rethrow;
  }
});

final currentDaySummaryProvider =
    Provider.autoDispose<Map<String, dynamic>>((ref) {
  try {
    final List<TransactionsModel> data = TransactionRepository().getAllToday();

    double r = 0;
    double p = 0;

    for (var txn in data) {
      if (txn.txnType == 'PAYMENT') {
        p = p + txn.amountDr;
      }

      if (txn.txnType == 'RECEIVE') {
        r = r + txn.amountCr;
      }
    }

    return {'income': r, 'expenditure': p};
  } catch (e) {
    rethrow;
  }
});

//--Recent Activity
final recentActivityProvider =
    Provider.autoDispose<List<Map<String, dynamic>>>((ref) {
  try {
    final List<TransactionsModel> data = TransactionRepository().getAllToday();

    List<Map<String, dynamic>> mDataList = [];

    for (var element in data) {
      mDataList.addAll(
        [
          {
            'account': element.accountName,
            'amount':
                element.amountCr == 0 ? element.amountDr : element.amountCr,
            'txnMode': element.txnType,
            'createdOn': element.createdOn
          }
        ],
      );
    }

    return mDataList;
  } catch (e) {
    rethrow;
  }
});
