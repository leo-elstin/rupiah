import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view_model/account/create_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddAccount extends ConsumerStatefulWidget {
  static const route = '/add-account';

  const AddAccount({super.key});

  @override
  ConsumerState<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends ConsumerState<AddAccount> {
  @override
  Widget build(BuildContext context) {
    var uiState = ref.read(createAccountState.notifier);

    AccountEntity entity = ref.watch(createAccountState);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<AccountType>(
              showSelectedIcon: false,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              segments: const [
                ButtonSegment<AccountType>(
                  value: AccountType.savings,
                  label: Text('Savings '),
                ),
                ButtonSegment<AccountType>(
                  value: AccountType.credit,
                  label: Text('Credit Card'),
                ),
                ButtonSegment<AccountType>(
                  value: AccountType.loan,
                  label: Text('Loan '),
                ),
              ],
              selected: <AccountType>{entity.accountType},
              onSelectionChanged: (Set<AccountType> newSelection) {
                uiState.updateAccount(entity.copyWith(
                  accountType: newSelection.first,
                ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 32),
                  TextField(
                    textCapitalization: TextCapitalization.words,
                    style: context.titleMedium(),
                    decoration: textDecoration.copyWith(
                      labelText: 'Account Holder Name',
                      labelStyle: context.titleLarge(),
                    ),
                    onChanged: (value) {
                      uiState.updateAccount(entity.copyWith(
                        description: value,
                      ));
                    },
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    textCapitalization: TextCapitalization.words,
                    style: context.titleMedium(),
                    decoration: textDecoration.copyWith(
                      labelText: 'Account Name',
                      labelStyle: context.titleLarge(),
                    ),
                    onChanged: (value) {
                      uiState.updateAccount(entity.copyWith(
                        accountName: value,
                      ));
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
                      labelText: 'Account Balance',
                      hintText: '$currencySymbol 0.00',
                      labelStyle: context.titleLarge(),
                    ),
                    onChanged: (value) {
                      uiState.updateAccount(entity.copyWith(
                        balance: formatter.getUnformattedValue().toDouble(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    ref.invalidate(createAccountState);
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
                  onPressed:
                      entity.accountName != null && entity.description != null
                          ? () {
                              ref
                                ..read(createAccountState.notifier)
                                    .addAccount(entity)
                                ..invalidate(createAccountState);

                              context.pop();
                            }
                          : null,
                  child: const Text('Add Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
