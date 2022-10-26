import 'package:flutter_screenutil/flutter_screenutil.dart';

double inputHeight = 45.0.h;

final List<Map<String, dynamic>> hasBankAccount = [
  {'code': 'YES', 'name': 'Yes, I have'},
  {'code': 'NO', 'name': "No, I don't"},
];

final List randomColor = [
  0xFFffebee,
  0xFFfce4ec,
  0xFFf3e5f5,
  0xFFede7f6,
  0xFFe8eaf6,
  0xFFe3f2fd,
  0xFFe1f5fe,
  0xFFe0f7fa,
  0xFFe0f2f1,
  0xFFe8f5e9,
  0xFFf1f8e9,
  0xFFf9fbe7,
  0xFFfffde7,
  0xFFfff8e1,
  0xFFfff3e0,
  0xFFfbe9e7,
  0xFFefebe9,
  0xFFfafafa,
  0xFFeceff1,
];

final txnType = ['RECEIPT', 'PAYMENT'];
final txnMode = ['Cash', 'Online', 'Cheque', 'Bank Transfer'];

final dateFormat = ['dd-MM-yyyy', 'MM-dd-yyyy', 'yyyy-MM-dd'];
final currencyFormat = ['###,##0.00', '##,#0.00'];

final yesNo = [
  {'key': true, 'value': 'Yes'},
  {'key': false, 'value': 'No'}
];

//--11/10/2022
final List<Map<String, dynamic>> accountType = [
  {'code': 'REVENUE', 'name': 'Revinue'},
  {'code': 'EXPENSES', 'name': 'Expenses'},
  {'code': 'ASSETS', 'name': 'Assets'},
  {'code': 'BANK', 'name': 'Bank'},
  {'code': 'LIABILITIES', 'name': 'Liabilities'},
  {'code': 'EQUITY', 'name': 'Equity'},
];
