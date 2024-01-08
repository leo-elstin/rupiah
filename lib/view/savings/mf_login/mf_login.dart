import 'dart:convert';
import 'dart:developer';

import 'package:expense_kit/model/entity/mf_central_login_entiry.dart';
import 'package:expense_kit/view_model/mutual_fund/mf_login/mf_login_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class MFLogin extends StatefulWidget {
  static const route = '/mf-login';

  const MFLogin({super.key});

  @override
  StateModel<MFLogin, MfLoginCubit> createState() => _MFLoginState();
}

class _MFLoginState extends StateModel<MFLogin, MfLoginCubit> {
  InAppWebViewController? webViewController;

  @override
  Widget buildMobile(BuildContext context, MfLoginCubit cubit) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://app.mfcentral.com/investor/signin"),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          if (url
              .toString()
              .contains('https://app.mfcentral.com/portal/home')) {
            context.pop();
            dynamic data = await webViewController?.webStorage.localStorage
                .getItem(key: 'persist:mf-central');

            log(data['authReducer']);
            cubit.setupCredentials(
              MFCentralEntity.fromJson(
                jsonDecode(
                  data['authReducer'],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
