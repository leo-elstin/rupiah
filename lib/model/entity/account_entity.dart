// entity for the AccountTable

class AccountEntity {
  final String? accountName;
  final String? description;
  final String? colorCode;
  final String? iconCode;
  final double? balance;
  final String? id;

  AccountEntity({
    this.accountName,
    this.description,
    this.colorCode,
    this.iconCode,
    this.balance,
    this.id,
  });

  // copy with
  AccountEntity copyWith({
    String? accountName,
    String? description,
    String? colorCode,
    String? iconCode,
    String? id,
    double? balance,
  }) {
    return AccountEntity(
      accountName: accountName ?? this.accountName,
      description: description ?? this.description,
      colorCode: colorCode ?? this.colorCode,
      iconCode: iconCode ?? this.iconCode,
      id: id ?? this.id,
      balance: balance ?? this.balance,
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'accountName': accountName,
      'description': description,
      'colorCode': colorCode,
      'iconCode': iconCode,
      'balance': balance,
      'id': id,
    };
  }

  // from json
  factory AccountEntity.fromMap(Map<String, dynamic> map) {
    return AccountEntity(
      accountName: map['accountName'],
      description: map['description'],
      colorCode: map['colorCode'],
      iconCode: map['iconCode'],
      balance: map['balance'],
      id: map['id'],
    );
  }
}
