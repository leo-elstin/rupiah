import 'dart:io';

import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdf_text/pdf_text.dart';

class AddInvestment extends StatefulWidget {
  const AddInvestment({super.key});

  @override
  StateModel<AddInvestment, SavingsCubit> createState() =>
      _AddInvestmentState();
}

class _AddInvestmentState extends StateModel<AddInvestment, SavingsCubit> {
  TextEditingController fileController = TextEditingController();
  bool obscureText = true;
  File? file;
  String? password;

  String stocks = '0.0';
  String mf = '0.0';
  DateTime? date;

  @override
  Widget buildMobile(BuildContext context, SavingsCubit cubit) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text('Add Investment'),
            const SizedBox(height: 16),
            TextField(
              controller: fileController,
              decoration: textDecoration.copyWith(
                hintText: 'Pick File',
                suffixIcon: const Icon(Icons.picture_as_pdf_rounded),
              ),
              readOnly: true,
              onTap: () {
                FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                ).then((value) {
                  if (value != null) {
                    fileController.text = value.files.first.name;
                    file = File(value.files.first.path!);
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: obscureText,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              decoration: textDecoration.copyWith(
                hintText: 'PDF Password',
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                counterText: '',
              ),
              onChanged: (value) {
                password = value;
              },
              maxLength: 10,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your PAN number won\'t be stored or processed',
                  style: context.smaller(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (date != null)
              Card(
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
                          const Expanded(child: Text('Month/Year')),
                          Expanded(
                            child: Text(
                              DateFormat('MMM, yyyy').format(
                                date!,
                              ),
                              style: context.boldBody(),
                            ),
                          ),
                        ],
                      ),
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
            const SizedBox(height: 16),
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
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
                      onPressed: () {
                        if (date != null) {
                          return;
                        }
                        if (password != null &&
                            password?.length == 10 &&
                            file != null) {
                          validatePDF(file!.path, password!);
                        }
                      },
                      child: Text(
                        date == null ? 'Process PDF' : 'Update Investment',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validatePDF(String s, String password) async {
    File file = File(s);
    PDFDoc doc = await PDFDoc.fromFile(
      file,
      password: password.toUpperCase(),
    );

    String text = await doc.text;
    var spText = text.split('Mutual Fund Folios');

    var splitAmounts = spText[1].split('Click Here');
    var amounts = splitAmounts[0].split(' ');

    stocks = amounts[0];
    mf = amounts[2];
    var item = RegExp(
      r'PERIOD FROM ([0-9-0-9-0-9]+)',
    ).firstMatch(text)?.group(1);

    setState(() {
      date = DateFormat('dd-MM-yyyy').parse(item!);
    });
  }
}
