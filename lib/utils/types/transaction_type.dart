import 'package:freezed_annotation/freezed_annotation.dart';

/// Transaction types allowed in the app.
enum TransactionType {
  /// Represents an income transaction.
  @JsonValue('income')
  income,

  /// Represents an expense transaction.
  @JsonValue('expense')
  expense;
}
