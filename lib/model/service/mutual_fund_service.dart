import 'package:expense_kit/model/entity/mutual_fund.dart';
import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/model/service/api_client.dart';
import 'package:expense_kit/model/service/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class MutualFundService {
  final ApiClient _client = ApiClient();

  final String _basePath = 'https://api.mfapi.in/mf';

  final Logger _logger = Logger();

  Future<MutualFundEntity?> getDetails(String fundId) async {
    _logger.d('GET MF Details: $fundId');
    try {
      var response = await _client.get('$_basePath/$fundId/latest');

      if (response == null) {
        return null;
      }
      if (kDebugMode) {
        print(response);
      }
      return MutualFundEntity.fromJson(response);
    } on ServiceError catch (e) {
      e.log();
      return null;
    }
  }

  Future<List<Scheme>> getFunds() async {
    dynamic response;

    response = await _client.get(_basePath);

    return schemesFromJson(response);
  }

  Future<List<Scheme>> searchFund({required String query}) async {
    dynamic response;

    try {
      _logger.d('Search => $_basePath/search?q=$query');
      response = await _client.get('$_basePath/search?q=$query');

      return schemesFromJson(response);
    } on ServiceError catch (e) {
      e.log();
      return [];
    }
  }
}
