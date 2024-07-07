import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_app/utils/types/transaction_type.dart';

part 'transaction_dto.freezed.dart';
part 'transaction_dto.g.dart';

@freezed

/// The transaction data transfer object.
class TransactionDto with _$TransactionDto {
  /// Creates a transaction data transfer object.
  factory TransactionDto({
    required int id,
    required String title,
    required double amount,
    required DateTime date,
    required TransactionType type,
    String? description,
    String? longDescription,
  }) = _TransactionDto;

  /// Creates a transaction data transfer object from JSON.
  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);
}
