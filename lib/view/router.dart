import 'package:expense_kit/view/account/account_list.dart';
import 'package:expense_kit/view/account/add_account.dart';
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
  ],
);
