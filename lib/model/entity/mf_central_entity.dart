class PortfolioData {
  final String reqId;
  final String pan;
  final String pekrn;
  final String mobile;
  final String email;
  final List<Data> data;
  final String tempDpId;
  final List<Portfolio> portfolio;

  PortfolioData({
    required this.reqId,
    required this.pan,
    required this.pekrn,
    required this.mobile,
    required this.email,
    required this.data,
    required this.tempDpId,
    required this.portfolio,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      reqId: json['reqId'],
      pan: json['pan'],
      pekrn: json['pekrn'],
      mobile: json['mobile'],
      email: json['email'],
      data: List<Data>.from(json['data'].map((e) => Data.fromJson(e))),
      tempDpId: json['tempDpId'],
      portfolio: List<Portfolio>.from(
          json['portfolio'].map((e) => Portfolio.fromJson(e))),
    );
  }
}

class Data {
  final List<Summary> summary;
  final List<Scheme> schemes;

  Data({
    required this.summary,
    required this.schemes,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      summary:
          List<Summary>.from(json['summary'].map((e) => Summary.fromJson(e))),
      schemes:
          List<Scheme>.from(json['schemes'].map((e) => Scheme.fromJson(e))),
    );
  }
}

class Summary {
  final String amc;
  final String amcName;
  final String isDemat;
  final String currentMktValue;
  final String costValue;
  final String gainLoss;
  final String gainLossPercentage;

  Summary({
    required this.amc,
    required this.amcName,
    required this.isDemat,
    required this.currentMktValue,
    required this.costValue,
    required this.gainLoss,
    required this.gainLossPercentage,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      amc: json['amc'],
      amcName: json['amcName'],
      isDemat: json['isDemat'],
      currentMktValue: json['currentMktValue'].toString(),
      costValue: json['costValue'].toString(),
      gainLoss: json['gainLoss'].toString(),
      gainLossPercentage: json['gainLossPercentage'].toString(),
    );
  }
}

class Scheme {
  final String amc;
  final String amcName;
  final String folio;
  final String investorName;
  final int age;
  final String schemeCode;
  final String schemeName;
  final String schemeOption;
  final String assetType;
  final String schemeType;
  final String nav;
  final String navDate;
  final String closingBalance;
  final String availableUnits;
  final String availableAmount;
  final String currentMktValue;
  final String costValue;
  final String gainLoss;
  final String gainLossPercentage;
  final String isDemat;
  final String lienUnitsFlag;
  final int decimalUnits;
  final int decimalAmount;
  final int decimalNav;
  final String brokerCode;
  final String brokerName;
  final String isin;
  final String purAllow;
  final String redAllow;
  final String swtAllow;
  final String sipAllow;
  final String stpAllow;
  final String swpAllow;
  final String planMode;
  final String dpId;
  final String rtaName;
  final String nomineeStatus;

  Scheme({
    required this.amc,
    required this.amcName,
    required this.folio,
    required this.investorName,
    required this.age,
    required this.schemeCode,
    required this.schemeName,
    required this.schemeOption,
    required this.assetType,
    required this.schemeType,
    required this.nav,
    required this.navDate,
    required this.closingBalance,
    required this.availableUnits,
    required this.availableAmount,
    required this.currentMktValue,
    required this.costValue,
    required this.gainLoss,
    required this.gainLossPercentage,
    required this.isDemat,
    required this.lienUnitsFlag,
    required this.decimalUnits,
    required this.decimalAmount,
    required this.decimalNav,
    required this.brokerCode,
    required this.brokerName,
    required this.isin,
    required this.purAllow,
    required this.redAllow,
    required this.swtAllow,
    required this.sipAllow,
    required this.stpAllow,
    required this.swpAllow,
    required this.planMode,
    required this.dpId,
    required this.rtaName,
    required this.nomineeStatus,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) {
    return Scheme(
      amc: json['amc'],
      amcName: json['amcName'],
      folio: json['folio'],
      investorName: json['investorName'],
      age: json['age'],
      schemeCode: json['schemeCode'],
      schemeName: json['schemeName'],
      schemeOption: json['schemeOption'],
      assetType: json['assetType'],
      schemeType: json['schemeType'],
      nav: json['nav'].toString(),
      navDate: json['navDate'],
      closingBalance: json['closingBalance'].toString(),
      availableUnits: json['availableUnits'].toString(),
      availableAmount: json['availableAmount'].toString(),
      currentMktValue: json['currentMktValue'].toString(),
      costValue: json['costValue'].toString(),
      gainLoss: json['gainLoss'].toString(),
      gainLossPercentage: json['gainLossPercentage'].toString(),
      isDemat: json['isDemat'],
      lienUnitsFlag: json['lienUnitsFlag'],
      decimalUnits: json['decimalUnits'],
      decimalAmount: json['decimalAmount'],
      decimalNav: json['decimalNav'],
      brokerCode: json['brokerCode'],
      brokerName: json['brokerName'],
      isin: json['isin'],
      purAllow: json['purAllow'],
      redAllow: json['redAllow'],
      swtAllow: json['swtAllow'],
      sipAllow: json['sipAllow'],
      stpAllow: json['stpAllow'],
      swpAllow: json['swpAllow'],
      planMode: json['planMode'],
      dpId: json['dpId'],
      rtaName: json['rtaName'],
      nomineeStatus: json['nomineeStatus'],
    );
  }
}

class Portfolio {
  final String currentMktValue;
  final String costValue;
  final String gainLoss;
  final String gainLossPercentage;
  final String isDemat;

  Portfolio({
    required this.currentMktValue,
    required this.costValue,
    required this.gainLoss,
    required this.gainLossPercentage,
    required this.isDemat,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      currentMktValue: json['currentMktValue'].toString(),
      costValue: json['costValue'].toString(),
      gainLoss: json['gainLoss'].toString(),
      gainLossPercentage: json['gainLossPercentage'].toString(),
      isDemat: json['isDemat'],
    );
  }
}
