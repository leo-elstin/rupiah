import 'package:expense_kit/model/entity/mf_central_entity.dart';
import 'package:expense_kit/model/entity/mutual_fund.dart';
import 'package:expense_kit/model/service/api_client.dart';
import 'package:expense_kit/model/service/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class MutualFundService {
  final ApiClient _client = ApiClient();

  final String _basePath = 'https://api.mfapi.in/mf';

  final Logger _logger = Logger();

  Future<MutualFundEntity?> getDetails(String fundId) async {
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

  // Future<List<Scheme>> getFunds() async {
  //   dynamic response;
  //
  //   response = await _client.get(_basePath);
  //
  //   return schemesFromJson(response);
  // }

  // Future<List<Scheme>> searchFund({required String query}) async {
  //   dynamic response;
  //
  //   try {
  //     _logger.d('Search => $_basePath/search?q=$query');
  //     response = await _client.get('$_basePath/search?q=$query');
  //
  //     return schemesFromJson(response);
  //   } on ServiceError catch (e) {
  //     e.log();
  //     return [];
  //   }
  // }

  Future<PortfolioData?> getMFPortfolio({
    required String mobileNo,
    required String pan,
    required String reqId,
    required String token,
  }) async {
    try {
      var response = await _client.post(
        'https://services.mfcentral.com/user/getportfolio',
        data: {
          "email": "",
          "mobile": mobileNo,
          "pan": pan,
          "pekrn": "",
          "reqId": reqId,
          "metaData": {
            "appType": "WEB",
            "OSVersion": "",
            "deviceName": "",
            "deviceOS": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 "
                "Safari/537.36"
          }
        },
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'authorization': 'Bearer $token',
          'origin': 'https://app.mfcentral.com',
        },
      );

      if (response == null) {
        return null;
      }
      if (kDebugMode) {
        print(response);
      }
      return PortfolioData.fromJson(response);
    } on ServiceError catch (e) {
      e.log();
      return null;
    }
  }
}
