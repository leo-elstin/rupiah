import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view_model/emi/create_emi_state.dart';
import 'package:expense_kit/view_model/emi/emi_list_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class AddEMI extends ConsumerStatefulWidget {
  static const route = '/add-emi';
  const AddEMI({super.key});

  @override
  ConsumerState<AddEMI> createState() => _AddEMIState();
}

class _AddEMIState extends ConsumerState<AddEMI> {
  TextEditingController dateController = TextEditingController();

  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(emiState, (previous, next) {
      if (next.endDate != null) {
        dateController.text = DateFormat.yMMM().format(next.endDate!);
      }
    });

    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      symbol: '${CurrencyUtils.currencySymbol} ',
      locale: 'en_IN',
    );

    var uiState = ref.read(emiState.notifier);

    EMIEntity emiEntity = ref.watch(emiState);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add EMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: ListView(
            children: [
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: context.titleMedium(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  formatter,
                ],
                decoration: textDecoration.copyWith(
                  labelText: 'EMI Amount',
                  hintText: '$currencySymbol 0.00',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  uiState.amount(
                    formatter.getUnformattedValue().toDouble(),
                  );
                },
              ),
              const SizedBox(height: 32),
              TextField(
                style: context.titleMedium(),
                decoration: textDecoration.copyWith(
                  labelText: 'Pending EMIs',
                  hintText: '0',
                  labelStyle: context.titleLarge(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    count = int.parse(value);
                    var jiffy = Jiffy.now().add(
                      months: int.parse(value) - 1,
                    );

                    if (kDebugMode) {
                      print(jiffy.dateTime);
                    }

                    uiState.updateEMI(emiEntity.copyWith(
                      endDate: jiffy.dateTime,
                    ));
                  }
                },
              ),
              const SizedBox(height: 32),
              TextField(
                controller: dateController,
                style: context.titleMedium(),
                readOnly: true,
                decoration: textDecoration.copyWith(
                  labelText: 'EMI End Date',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 32),
              TextField(
                style: context.body(),
                decoration: textDecoration.copyWith(
                  labelText: 'Description',
                  hintText: 'Optional',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  uiState.updateEMI(emiEntity.copyWith(
                    description: value,
                  ));
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
                    ref.invalidate(emiState);
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
                  onPressed: emiEntity.amount > 0 && emiEntity.endDate != null
                      ? () {
                          ref
                            ..read(emiState.notifier).addEMI(emiEntity, count)
                            ..invalidate(emiState)
                            ..read(emiListProvider.notifier).getAll();

                          context.pop();
                        }
                      : null,
                  child: const Text('Add Expense'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
