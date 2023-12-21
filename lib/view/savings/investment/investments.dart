import 'dart:developer';
import 'dart:io';

import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/savings/investment/add_investment.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_text/pdf_text.dart';

class PDFReader extends StatefulWidget {
  static const route = '/pdf-reader';

  const PDFReader({super.key});

  @override
  State<PDFReader> createState() => _PDFReaderState();
}

class _PDFReaderState extends State<PDFReader> {
  String stocks = '0.0';
  String mf = '0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investments'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddInvestment(),
          );

          return;
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            File file = File(result.files.single.path!);
            PDFDoc doc = await PDFDoc.fromFile(
              file,
              password: 'AZBPL3776E',
            );

            String text = await doc.text;
            var spText = text.split('Mutual Fund Folios');

            var splitAmounts = spText[1].split('Click Here');
            var amounts = splitAmounts[0].split(' ');

            for (var value in amounts) {
              if (value.isNotEmpty) {
                log(value.replaceAll('\n', ''));
              }
            }

            setState(() {});

            // TODO: move it above the future call
            context.read<SavingsCubit>().update(
                  double.parse(stocks.replaceAll(',', '').trim()),
                  double.parse(mf.replaceAll(',', '').trim()),
                );
          } else {
            // User canceled the picker
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Portfolio Valuation'),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Stocks')),
                    Expanded(
                      child: Text(
                        formatter.format(stocks),
                        style: context.boldBody(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Mutual Funds')),
                    Expanded(
                      child: Text(
                        formatter.format(mf),
                        style: context.boldBody(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
