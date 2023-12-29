class MutualFundEntity {
  Meta meta;
  List<Data> data;
  String status;

  double get currentNav => double.parse(data.first.nav);

  MutualFundEntity(
      {required this.meta, required this.data, required this.status});

  factory MutualFundEntity.fromJson(Map<String, dynamic> json) {
    return MutualFundEntity(
      meta: Meta.fromJson(json['meta']),
      data: List<Data>.from(json['data'].map((data) => Data.fromJson(data))),
      status: json['status'],
    );
  }
}

class Meta {
  String fundHouse;
  String schemeType;
  String schemeCategory;
  int schemeCode;
  String schemeName;

  Meta({
    required this.fundHouse,
    required this.schemeType,
    required this.schemeCategory,
    required this.schemeCode,
    required this.schemeName,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      fundHouse: json['fund_house'],
      schemeType: json['scheme_type'],
      schemeCategory: json['scheme_category'],
      schemeCode: json['scheme_code'],
      schemeName: json['scheme_name'],
    );
  }
}

class Data {
  String date;
  String nav;

  Data({required this.date, required this.nav});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      date: json['date'],
      nav: json['nav'],
    );
  }
}
