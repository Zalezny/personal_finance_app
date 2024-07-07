import 'package:flutter/material.dart';
import 'package:personal_finance_app/core/models/transaction_model.dart';
import 'package:personal_finance_app/ui/screens/home/widgets/transaction_widget.dart';
import 'package:personal_finance_app/utils/extensions/l10n_extension.dart';
import 'package:personal_finance_app/utils/extensions/style_extension.dart';


/// A widget that displays the table section.
class TableSection extends StatelessWidget {
  /// Creates the TableSection
  const TableSection({
    required this.transactions,
    required this.verticalPadding,
    super.key,
  });
  /// The transactions to display
  final List<Transaction> transactions;
  /// The vertical padding for the screen between elements
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                context.l10n.dateColumn,
                style: context.textTheme.titleLarge,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                context.l10n.descriptionColumn,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                context.l10n.amountColumn,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SizedBox(height: verticalPadding / 4),
        Divider(color: context.colorScheme.onSurfaceVariant, thickness: 1),
        ...transactions.map((transaction) {
          return TransactionWidget(transaction: transaction);
        }),
      ],
    );
  }
}
