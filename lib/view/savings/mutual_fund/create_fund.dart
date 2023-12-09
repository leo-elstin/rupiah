import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/savings/mutual_fund/fund_search.dart';
import 'package:expense_kit/view_model/mutual_fund/mutual_fund_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFund extends StatefulWidget {
  static const route = '/create-fund';

  const CreateFund({super.key});

  @override
  State<CreateFund> createState() => _CreateFundState();
}

class _CreateFundState extends State<CreateFund> {
  Scheme? scheme;
  MFType type = MFType.sip;
  TextEditingController fundController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<MutualFundCubit>().calculateSip();
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
              const SizedBox(height: 32),
              SegmentedButton<MFType>(
                showSelectedIcon: false,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                segments: const [
                  ButtonSegment<MFType>(
                    value: MFType.sip,
                    label: Text('SIP'),
                  ),
                  ButtonSegment<MFType>(
                    value: MFType.lumpSum,
                    label: Text('Lump sum'),
                  ),
                ],
                selected: <MFType>{type},
                onSelectionChanged: (Set<MFType> newSelection) {
                  setState(() {
                    // By default there is only a single segment that can be
                    // selected at one time, so its value is always the first
                    // item in the selected set.
                    type = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 32),
              DropdownButtonFormField(
                decoration: textDecoration.copyWith(
                  labelText: 'SIP Interval',
                  labelStyle: context.titleLarge(),
                ),
                style: context.body(),
                isExpanded: true,
                value: SipPeriod.values.first,
                onChanged: (value) {},
                items: SipPeriod.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.capitalize(),
                          style: context.body(),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 32),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: context.titleMedium(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  formatter,
                ],
                decoration: textDecoration.copyWith(
                  labelText: 'SIP Start Date',
                  hintText: '08, Fri, 2023',
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
