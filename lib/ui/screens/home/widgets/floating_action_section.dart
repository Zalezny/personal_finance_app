import 'package:flutter/material.dart';
import 'package:personal_finance_app/core/providers/transactions_notifier.dart';

import 'package:personal_finance_app/ui/screens/home/widgets/new_transaction_pop_up.dart';

/// The floating action section.
class FloatingActionSection extends StatelessWidget {
  /// Creates the FloatingActionSection
  const FloatingActionSection({required this.transactionsNotifier, super.key});

  /// The transactions notifier
  final TransactionsNotifier transactionsNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: transactionsNotifier.fetchTransactions,
            child: const Icon(Icons.sync),
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showAddTransactionDialog(context, transactionsNotifier);
            },
          ),
        ],
      ),
    );
  }
}
