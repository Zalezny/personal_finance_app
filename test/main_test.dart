import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:personal_finance_app/data/dto/transaction_dto.dart';
import 'package:personal_finance_app/data/repositories/transaction_repository.dart';
import 'package:personal_finance_app/ui/screens/home/widgets/new_transaction_widget.dart';
import 'package:personal_finance_app/utils/classes/result.dart';
import 'package:personal_finance_app/utils/const/transaction_keys.dart';
import 'package:personal_finance_app/utils/extensions/l10n_extension.dart';
import 'package:personal_finance_app/utils/injection/injection.dart';

void main() {
  test('fetchTransactions should return a list of transactions', () async {
    await configureDependencies(injectable.Environment.dev);

    final repository = getIt<TransactionRepository>();
    final result = await repository.fetchTransactions();

    expect(result is Success, true);
    expect((result as Success).value, isA<List<TransactionDto>>());
  });

  testWidgets('NewTransactionWidget should validate and save form data',
      (WidgetTester tester) async {
    await configureDependencies(injectable.Environment.dev);
    // Build the NewTransactionWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Localizations(
          locale: const Locale('en'),
          delegates: AppLocalizations.localizationsDelegates,
          child: NewTransactionWidget(
            onAdded: (p0, p1, p2, p3) {
              expect(p0, isA<DateTime>());
            },
          ),
        ),
      ),
    );

    // Enter valid form data
    await tester.enterText(
      find.byKey(TransactionKeys.titleInputField),
      'Test Title',
    );
    await tester.enterText(
      find.byKey(TransactionKeys.amountInputField),
      '10.0',
    );
    await tester.tap(find.byKey(TransactionKeys.typeInputField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('expense').last);

    // Tap the add button
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Verify that the form data was saved and added to the transactions list
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('10.0'), findsOneWidget);
    expect(find.text('expense'), findsOneWidget);
    expect(find.text('OK'), findsNothing);
  });
}
