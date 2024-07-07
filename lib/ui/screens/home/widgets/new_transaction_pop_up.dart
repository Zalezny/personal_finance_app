import 'package:flutter/material.dart';
import 'package:personal_finance_app/core/models/transaction_model.dart';
import 'package:personal_finance_app/core/providers/transactions_notifier.dart';
import 'package:personal_finance_app/ui/screens/home/widgets/new_transaction_widget.dart';


/// Shows a dialog to add a new transaction
void showAddTransactionDialog(
  BuildContext context,
  TransactionsNotifier transactionsNotifier,
) {
  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return NewTransactionWidget(
        onAdded: (date, title, amount, type) {
          transactionsNotifier.addTransaction(
            Transaction(
              id: transactionsNotifier.getUniqueTransactionId(),
              date: date,
              amount: amount,
              title: title,
              type: type,
            ),
          );
        },
      );
    },
  );
}
