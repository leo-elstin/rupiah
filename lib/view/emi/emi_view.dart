import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/view/emi/add_emi.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:expense_kit/view_model/emi/emi_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EMIView extends ConsumerStatefulWidget {
  const EMIView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EMIViewState();
}

class _EMIViewState extends ConsumerState<EMIView> {
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    symbol: '$currencySymbol ',
    locale: 'en_IN',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();

    ref.read(emiListProvider.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Existing EMIs'),
        actions: [
          IconButton(
            onPressed: () => ref.read(emiListProvider.notifier).sort(),
            icon: Icon(
              ref.read(emiListProvider.notifier).asc
                  ? Icons.arrow_downward_sharp
                  : Icons.arrow_upward_sharp,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(page: const AddEMI()),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: ref.watch(emiListProvider).length,
        itemBuilder: (context, index) {
          EMIEntity entity = ref.watch(emiListProvider)[index];
          return ListTile(
              onLongPress: () {
                ref.read(emiListProvider.notifier).delete(entity);
              },
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      entity.description?.toString() ?? 'EMI',
                      style: context.body(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      formatter.formatDouble(entity.amount),
                      textAlign: TextAlign.end,
                      style: context.boldBody(),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity.formattedDate(),
                    style: context.small(),
                  ),
                ],
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Icon(
                  Icons.currency_rupee,
                  color: Colors.white,
                  size: 16,
                ),
              ));
        },
      ),
    );
  }
}
