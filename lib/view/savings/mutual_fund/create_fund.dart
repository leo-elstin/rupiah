import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/savings/mutual_fund/fund_search.dart';
import 'package:expense_kit/view_model/mutual_fund/create/create_mf_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CreateFund extends StatefulWidget {
  static const route = '/create-fund';

  const CreateFund({super.key});

  @override
  StateModel<CreateFund, CreateMfCubit> createState() => _CreateFundState();
}

class _CreateFundState extends StateModel<CreateFund, CreateMfCubit> {
  TextEditingController fundController = TextEditingController();

  @override
  Widget buildMobile(BuildContext context, CreateMfCubit cubit) {
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
                          cubit.scheme = value;
                          fundController.text = value.schemeName;
                          cubit.fundDetails();
                        },
                      );
                    },
                  );
                },
                readOnly: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
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
              const SizedBox(height: 16),
              if (cubit.fund != null)
                Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Fund Details'),
                            const Divider(),
                            const SizedBox(
                              height: 8,
                            ),
                            // Row(
                            //   children: [
                            //     const Expanded(child: Text('Month/Year')),
                            //     Expanded(
                            //       child: Text(
                            //         DateFormat('MMM, yyyy').format(
                            //           date!,
                            //         ),
                            //         style: context.boldBody(),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('NAV')),
                                Expanded(
                                  child: Text(
                                    cubit.fund?.currentNav.toCurrency() ?? 'NA',
                                    style: context.boldBody(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('Fund House')),
                                Expanded(
                                  child: Text(
                                    cubit.fund?.meta.fundHouse ?? 'NA',
                                    style: context.boldBody(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              SegmentedButton<MFType>(
                showSelectedIcon: false,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
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
                selected: <MFType>{cubit.type},
                onSelectionChanged: (Set<MFType> newSelection) {
                  cubit.type = newSelection.first;
                },
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
                  labelText: 'Invested Amount',
                  hintText: '$currencySymbol 0.00',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  cubit.amount = formatter.getUnformattedValue();
                },
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
                  labelText: 'Current Value',
                  hintText: '$currencySymbol 0.00',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  cubit.currentValue = formatter.getUnformattedValue();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                  ),
                  onPressed: cubit.isValid
                      ? () {
                          context.pop();
                          cubit.insert();
                        }
                      : null,
                  child: const Text('Add Fund'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
