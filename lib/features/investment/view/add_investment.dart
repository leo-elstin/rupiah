import 'dart:io';

import 'package:expense_kit/features/investment/view_model/investments_cubit.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddInvestment extends StatefulWidget {
  static const route = '/add-investment';

  const AddInvestment({super.key});

  @override
  StateModel<AddInvestment, InvestmentsCubit> createState() => _AddInvestmentState();
}

class _AddInvestmentState extends StateModel<AddInvestment, InvestmentsCubit> {
  TextEditingController fileController = TextEditingController();
  File? file;
  String? password;

  String stocks = '0.0';
  String mf = '0.0';
  DateTime? date;

  @override
  Widget buildMobile(BuildContext context, InvestmentsCubit cubit) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text('Real Estate Details'),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.name,
                  decoration: textDecoration.copyWith(
                    labelText: 'Investment Name',
                    hintText: 'Farm House, Apartment, etc.',
                    hintStyle: context.hintText(),
                  ),
                  onChanged: (value) {
                    cubit.investmentModel.copyWith(description: value);
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.name,
                  decoration: textDecoration.copyWith(
                    labelText: 'Invested Value',
                    hintText: '$currency 0.00',
                  ),
                  inputFormatters: [
                    currencyFormatter,
                  ],
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: textDecoration.copyWith(
                    labelText: 'Date of Investment',
                    hintText: 'DD/MM/YYYY',
                    hintStyle: context.hintText(),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: textDecoration.copyWith(
                    labelText: 'Current Value',
                    hintText: '$currency 0.00',
                  ),
                  inputFormatters: [
                    currencyFormatter,
                  ],
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Your data will stay safe and secure in your device.',
                      style: context.smaller(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SafeArea(
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
                          onPressed: cubit.investmentModel.isValid ? () {} : null,
                          child: Text(
                            date == null ? 'Process PDF' : 'Update Investment',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
