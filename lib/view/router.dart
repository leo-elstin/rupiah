import 'package:expense_kit/features/funds/view/mutual_funds_page.dart';
import 'package:expense_kit/features/investment/view/add_investment.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/view/account/account_list.dart';
import 'package:expense_kit/view/account/add_account.dart';
import 'package:expense_kit/view/category/add_category.dart';
import 'package:expense_kit/view/category/category_list.dart';
import 'package:expense_kit/view/emi/add_emi.dart';
import 'package:expense_kit/view/expense/add_expense.dart';
import 'package:expense_kit/view/home/home.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: AddAccount.route,
      builder: (context, state) => const AddAccount(),
    ),
    GoRoute(
      path: AccountsList.route,
      builder: (context, state) => const AccountsList(),
    ),
    GoRoute(
      path: AddExpense.route,
      builder: (context, state) => AddExpense(
        expenseEntity: state.extra != null ? state.extra as ExpenseEntity : null,
      ),
    ),
    GoRoute(
      path: AddEMI.route,
      builder: (context, state) => const AddEMI(),
    ),
    GoRoute(
      path: MutualFundPage.route,
      builder: (context, state) => const MutualFundPage(),
    ),
    GoRoute(
      path: AddCategory.route,
      builder: (context, state) => const AddCategory(),
    ),
    GoRoute(
      path: CategoryList.route,
      builder: (context, state) => const CategoryList(),
    ),
    GoRoute(
      path: AddInvestment.route,
      builder: (context, state) => const AddInvestment(),
    ),
  ],
);
