import 'dart:async';

import 'package:expense_kit/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StateModel<T extends StatefulWidget, C extends Cubit>
    extends State<T> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initView(context.read<C>());

      _subscription = context.read<C>().stream.listen((state) {
        listener(state);
      });
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: context.read<C>(),
        builder: (context, state) => context.isTab
            ? buildTab(context, context.read<C>())
            : buildMobile(context, context.read<C>()),
      );

  Widget buildTab(BuildContext context, C cubit) {
    return context.widget;
  }

  Widget buildMobile(BuildContext context, C cubit) {
    return context.widget;
  }

  void listener(dynamic state) {}

  void initView(C cubit) {}

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
