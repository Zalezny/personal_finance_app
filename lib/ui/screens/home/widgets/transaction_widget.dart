import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_app/core/models/transaction_model.dart';
import 'package:personal_finance_app/utils/extensions/style_extension.dart';
import 'package:personal_finance_app/utils/types/transaction_type.dart';

/// A widget that displays a transaction.
class TransactionWidget extends StatelessWidget {
  /// Creates the TransactionWidget
  TransactionWidget({required this.transaction, super.key});

  /// The displayed transaction
  final Transaction transaction;

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Row(
          children: [
            Expanded(
              child: Text(
                _dateFormat.format(transaction.date),
                style: context.textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: Text(
                transaction.title,
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Expanded(
              child: Text(
                '${transaction.type == TransactionType.income ? '+' : '-'}'
                '\$${transaction.amount.abs().toStringAsFixed(2)}',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Divider(
          color: context.colorScheme.onSurfaceVariant.withOpacity(0.3),
          thickness: 1,
        ),
      ],
    );
  }
}
