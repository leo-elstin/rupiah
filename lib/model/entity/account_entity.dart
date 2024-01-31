// entity for the AccountTable

import 'package:expense_kit/model/database/tables/account.dart';

class AccountEntity {
  final String? accountName;
  final String? description;
  final String? colorCode;
  final String? iconCode;
  final double? balance;
  final AccountType accountType;
  final int? id;

  AccountEntity({
    this.accountName,
    this.description,
    this.colorCode,
    this.iconCode,
    this.balance,
    this.id,
    this.accountType = AccountType.savings,
  });

  // copy with
  AccountEntity copyWith({
    String? accountName,
    String? description,
    String? colorCode,
    String? iconCode,
    int? id,
    double? balance,
    AccountType? accountType,
  }) {
    return AccountEntity(
      accountName: accountName ?? this.accountName,
      description: description ?? this.description,
      colorCode: colorCode ?? this.colorCode,
      iconCode: iconCode ?? this.iconCode,
      id: id ?? this.id,
      balance: balance ?? this.balance,
      accountType: accountType ?? this.accountType,
    );
  }
}
