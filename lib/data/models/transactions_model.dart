import 'package:objectbox/objectbox.dart';

@Entity()
class TransactionsModel {
  int id;

  @Index()
  @Property(type: PropertyType.int)
  int account;

  String? accountName;

  String? narration;
  String? description;

  @Property(type: PropertyType.float)
  double amountDr;

  @Property(type: PropertyType.float)
  double amountCr;

  @Index()
  String txnMode;

  @Index()
  @Property(type: PropertyType.int)
  int modeAccount;

  @Index()
  String txnType;

  @Index()
  @Property(type: PropertyType.int)
  int scrollNo;

  @Index()
  @Property(type: PropertyType.date)
  DateTime? txnDate;

  @Property(type: PropertyType.date)
  DateTime? createdOn = DateTime.now().toLocal();

  TransactionsModel({
    this.id = 0,
    required this.account,
    this.accountName = '',
    this.narration = '',
    this.amountDr = 0.00,
    this.amountCr = 0.00,
    this.txnMode = 'CASH',
    required this.modeAccount,
    this.txnType = 'PAYMENT',
    required this.scrollNo,
    required this.txnDate,
    required this.createdOn,
    this.description = '',
  });
}
