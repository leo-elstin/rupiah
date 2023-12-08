import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/savings/mutual_fund/fund_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateFund extends StatefulWidget {
  static const route = '/create-fund';

  const CreateFund({super.key});

  @override
  State<CreateFund> createState() => _CreateFundState();
}

class _CreateFundState extends State<CreateFund> {
  Scheme? scheme;
  TextEditingController fundController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Fund'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: fundController,
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return FundSearch(
                        onSelect: (Scheme value) {
                          scheme = value;
                          fundController.text = value.schemeName;
                          if (kDebugMode) {
                            print(scheme?.schemeCode);
                          }
                        },
                      );
                    },
                  );
                },
                readOnly: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: context.titleMedium(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  formatter,
                ],
                decoration: textDecoration.copyWith(
                  labelText: 'Fund',
                  hintText: 'Search Fund',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 32),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: context.titleMedium(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  formatter,
                ],
                decoration: textDecoration.copyWith(
                  labelText: 'Amount',
                  hintText: '$currencySymbol 0.00',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
