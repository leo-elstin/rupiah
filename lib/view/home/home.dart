import 'package:expense_kit/view/account/account_view.dart';
import 'package:expense_kit/view/dashboard/dashboard.dart';
import 'package:expense_kit/view/emi/emi_view.dart';
import 'package:expense_kit/view/expense/expense_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  Widget view = const Dashboard();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          if (index == 0) {
            view = const Dashboard();
          } else if (index == 1) {
            view = const ExpenseView();
          } else if (index == 2) {
            view = const EMIView();
          } else if (index == 3) {
            view = const AccountView();
          }
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.currency_rupee),
            selectedIcon: Icon(Icons.currency_rupee_outlined),
            label: 'Expense',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            selectedIcon: Icon(Icons.payments),
            label: 'Loans',
          ),

          // NavigationDestination(
          //   icon: Icon(Icons.savings_outlined),
          //   selectedIcon: Icon(Icons.savings),
          //   label: 'Savings',
          // ),
          NavigationDestination(
            icon: Icon(Icons.account_box_outlined),
            selectedIcon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
