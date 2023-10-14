import 'package:flutter/material.dart';

class AddAccount extends StatefulWidget {
  static const route = '/add-account';

  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  String? selected = 'savings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<String?>(
              showSelectedIcon: false,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              segments: const [
                ButtonSegment<String>(
                  value: 'savings',
                  label: Text('Savings '),
                ),
                ButtonSegment<String>(
                  value: 'credit',
                  label: Text('Credit Card'),
                ),
                ButtonSegment<String>(
                  value: 'loan',
                  label: Text('Loan '),
                ),
              ],
              selected: <String?>{selected},
              onSelectionChanged: (Set<String?> newSelection) {
                setState(() {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  selected = newSelection.first;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
