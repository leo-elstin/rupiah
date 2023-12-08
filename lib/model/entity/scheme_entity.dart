class Scheme {
  final int schemeCode;
  final String schemeName;

  const Scheme({
    required this.schemeCode,
    required this.schemeName,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) {
    return Scheme(
      schemeCode: json['schemeCode'],
      schemeName: json['schemeName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'schemeCode': schemeCode,
        'schemeName': schemeName,
      };
}

List<Scheme> schemesFromJson(List<dynamic> json) {
  return json.map((dynamic e) => Scheme.fromJson(e)).toList();
}
