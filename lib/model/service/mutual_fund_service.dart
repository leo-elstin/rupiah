import 'package:expense_kit/model/entity/mutual_fund.dart';
import 'package:expense_kit/model/service/api_client.dart';
import 'package:flutter/foundation.dart';

class MutualFundService {
  final ApiClient _client = ApiClient();

  Future<MutualFund?> getDetails(String fundId) async {
    var response = await _client.get('https://api.mfapi.in/mf/$fundId/latest');

    if (response == null) {
      return null;
    }
    if (kDebugMode) {
      print(response);
    }
    return MutualFund.fromJson(response);
  }
}
