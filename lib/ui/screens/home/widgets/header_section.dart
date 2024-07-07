import 'package:flutter/material.dart';
import 'package:personal_finance_app/utils/extensions/l10n_extension.dart';
import 'package:personal_finance_app/utils/extensions/style_extension.dart';
/// A widget that displays the header section.
class HeaderSection extends StatelessWidget {
  /// Creates the HeaderSection
  const HeaderSection({
    required this.balance,
    required this.verticalPadding,
    super.key,
  });

  /// The balance to display
  final double balance;
  /// The vertical padding for the screen between elements
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final isPositive = balance >= 0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.pageTitle,
              style: context.textTheme.headlineLarge,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: verticalPadding),
          Center(
            child: Text(
              '${isPositive ? '+' : '-'}\$${balance.abs().toStringAsFixed(2)}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
