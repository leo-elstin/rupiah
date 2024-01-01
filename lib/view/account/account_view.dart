import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/view/account/account_list.dart';
import 'package:expense_kit/view/category/category_list.dart';
import 'package:expense_kit/view_model/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: ListView(
        children: [
          // ListTile(
          //   leading: Container(
          //     padding: const EdgeInsets.all(8),
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.deepOrange,
          //     ),
          //     child: const Icon(
          //       Icons.login_outlined,
          //       color: Colors.white,
          //       size: 16,
          //     ),
          //   ),
          //   title: const Text('Login/SignUp'),
          //   subtitle: const Text(
          //     'Login or Sign up to keep the data sync between devices',
          //   ),
          //   onTap: () => showModalBottomSheet(
          //     isDismissible: false,
          //     enableDrag: false,
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) => const AuthSheet(),
          //   ),
          // ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            title: const Text('Bank Accounts'),
            subtitle: const Text('add or remove bank account'),
            onTap: () => context.push(AccountsList.route),
          ),
          ListTile(
            title: const Text('Credit Cards'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: const Icon(
                Icons.credit_card_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            subtitle: const Text('add or remove Credit Card'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Loan Accounts'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.real_estate_agent_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            subtitle: const Text('add or remove Loan account'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Categories'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
              child: const Icon(
                Icons.category_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            subtitle: const Text('add or remove categories'),
            onTap: () => context.push(CategoryList.route),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Others'),
          ),
          ListTile(
            title: const Text('Settings'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.brown,
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            onTap: () {},
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              var cubit = context.read<SettingsCubit>();
              bool dark = cubit.brightness == Brightness.dark;
              return ListTile(
                title: const Text('Dark Theme'),
                subtitle: const Text('Switch between light and dark theme'),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dark ? Colors.white : Colors.black,
                  ),
                  child: Icon(
                    dark ? Icons.dark_mode : Icons.light_mode,
                    color: !dark ? Colors.white : Colors.black,
                    size: 16,
                  ),
                ),
                trailing: Switch(
                  value: dark,
                  onChanged: (value) {
                    cubit.changeBrightness();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Export Data'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(
                Icons.import_export_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Reset Expense Table'),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(
                Icons.lock_reset_outlined,
                color: Colors.deepOrange,
                size: 16,
              ),
            ),
            onLongPress: () {
              database.delete(database.expense).go();
            },
          ),
        ],
      ),
    );
  }
}
