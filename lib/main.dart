import 'package:expense_kit/model/service/login_service.dart';
import 'package:expense_kit/view/router.dart';
import 'package:expense_kit/view_model/auth/auth_cubit.dart';
import 'package:expense_kit/view_model/category/category_cubit.dart';
import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:expense_kit/view_model/mutual_fund/create/create_mf_cubit.dart';
import 'package:expense_kit/view_model/mutual_fund/mf_login/mf_login_cubit.dart';
import 'package:expense_kit/view_model/mutual_fund/mutual_fund_cubit.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    LoginService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..validateLogin(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit()..init(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider(
          create: (context) => SavingsCubit(
            dashboardCubit: context.read<DashboardCubit>(),
          )..getFunds(),
        ),
        BlocProvider(
          create: (context) => MutualFundCubit(),
        ),
        BlocProvider(
          create: (context) => CreateMfCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..get(),
        ),
        BlocProvider(
          create: (context) => MfLoginCubit(
            savingsCubit: context.read<SavingsCubit>(),
          ),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) => current is ThemeChanged,
        builder: (context, state) {
          var textTheme = Theme.of(context).textTheme;
          if (state is ThemeChanged && state.brightness == Brightness.dark) {
            textTheme = Theme.of(context).primaryTextTheme;
          } else {
            textTheme = Theme.of(context).textTheme;
          }
          return MaterialApp.router(
            title: 'Rupiah',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness:
                    state is ThemeChanged ? state.brightness : Brightness.light,
              ),
              useMaterial3: true,
              textTheme: GoogleFonts.openSansTextTheme(textTheme),
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
