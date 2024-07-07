import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_finance_app/core/models/transaction_model.dart';
import 'package:personal_finance_app/core/services/sample_transactions_service.dart';
import 'package:personal_finance_app/data/dto/transaction_dto.dart';
import 'package:personal_finance_app/data/repositories/transaction_repository.dart';
import 'package:personal_finance_app/utils/classes/result.dart';
import 'package:personal_finance_app/utils/const/server_consts.dart';
import 'package:personal_finance_app/utils/injection/injection.dart';
import 'package:personal_finance_app/utils/logs/logger.dart';
import 'package:personal_finance_app/utils/types/transaction_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_notifier.g.dart';

/// A class that notifies listeners of changes to transactions.
@Riverpod(keepAlive: true)
class TransactionsNotifier extends _$TransactionsNotifier {
  final _transactionRepository = getIt<TransactionRepository>();

  @override
  List<Transaction> build() {
    return state = getSampleTransactions();
  }

  /// Adds a transaction to the list of transactions.
  /// The transaction is added to the end of the list.
  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
    Logger.log('Added transaction: $transaction');
  }

  /// Fetch transactions from the server.
  /// The transactions are fetched from the [remoteTransactionsFileUrl].
  /// The fetched transactions are added to the list of transactions.
  Future<void> fetchTransactions() async {
    final result = await _transactionRepository.fetchTransactions();
    if (result is Success) {
      final transactionsDto = (result as Success).value as List<TransactionDto>;
      final transactions = transactionsDto
          .map(
            (e) => Transaction(
              id: e.id,
              title: e.title,
              amount: e.amount,
              date: e.date,
              type: e.type,
            ),
          )
          .toList();
      state = [...transactions];
      Logger.log('Transactions fetched successfully!');
      return;
    }
    unawaited(Fluttertoast.showToast(msg: 'Transactions fetched failed!'));
  }

  /// Returns the total amount of all transactions with 2 decimal places
  double getTotalAmount() {
    final totalAmount = state.fold(0.toDouble(), (previousValue, transaction) {
      final transAmount = transaction.type == TransactionType.expense
          ? -transaction.amount
          : transaction.amount;
      return previousValue + transAmount;
    });
    return double.parse(totalAmount.toStringAsFixed(2));
  }

  /// Returns a unique transaction ID for a new transaction
  /// The ID is the smallest positive integer that is not already used by
  /// any transaction
  int getUniqueTransactionId() {
    var uniqueId = 1;
    final transactionIds = state.map((transaction) => transaction.id).toList();
    while (transactionIds.contains(uniqueId)) {
      uniqueId++;
    }
    return uniqueId;
  }
}
