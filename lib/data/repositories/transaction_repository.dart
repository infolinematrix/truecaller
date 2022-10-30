import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/index.dart';

class TransactionRepository {
  final accountBox = store!.objStore.box<AccountsModel>();
  final transactionBox = store!.objStore.box<TransactionsModel>();

  //---------CURRENT DATE TRANSACTION LIST-----------//
  List<TransactionsModel> getAllToday(
      {int? accountNo, int? offset, int? limit}) {
    QueryBuilder<TransactionsModel> builder;

    if (accountNo == null) {
      builder = transactionBox.query(
        TransactionsModel_.txnDate
            .greaterOrEqual(dateTodayStart().millisecondsSinceEpoch)
            .and(TransactionsModel_.txnDate
                .lessOrEqual(DateTime.now().millisecondsSinceEpoch)),
      );
    } else {
      builder = transactionBox.query(
        TransactionsModel_.txnDate
            .greaterOrEqual(dateTodayStart().millisecondsSinceEpoch)
            .and(TransactionsModel_.txnDate
                .lessOrEqual(DateTime.now().millisecondsSinceEpoch))
            .and(TransactionsModel_.account.equals(accountNo)),
      );
    }

    //--Sorting
    builder.order(TransactionsModel_.id, flags: Order.descending);
    Query<TransactionsModel> query = builder.build();

    //--Limit
    if (limit != null) query.limit = limit;
    if (offset != null) query.offset = offset;

    List<TransactionsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //---------DATE RANGE TRANSACTION LIST---------------//
  List<TransactionsModel> getByDateRange(
      {int? accountNo,
      required DateTime startDate,
      required DateTime endtDate}) {
    QueryBuilder<TransactionsModel> builder;

    if (accountNo == null) {
      builder = transactionBox.query(
        TransactionsModel_.txnDate.between(
            startDate.millisecondsSinceEpoch, endtDate.millisecondsSinceEpoch),
      );
    } else {
      builder = transactionBox.query(TransactionsModel_.txnDate
          .between(
              startDate.millisecondsSinceEpoch, endtDate.millisecondsSinceEpoch)
          .and(TransactionsModel_.account.equals(accountNo)));
    }

    //--Sorting
    builder.order(TransactionsModel_.id, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();

    query.close();
    return data;
  }
}
