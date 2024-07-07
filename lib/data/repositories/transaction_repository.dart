import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:personal_finance_app/data/dto/transaction_dto.dart';
import 'package:personal_finance_app/data/service/api_service.dart';

import 'package:personal_finance_app/utils/classes/result.dart';
import 'package:personal_finance_app/utils/const/server_consts.dart';
import 'package:personal_finance_app/utils/injection/injection.dart';

/// The transaction repository.
@lazySingleton
class TransactionRepository {
  /// The API service.
  final apiService = getIt<ApiService>();

  /// Fetches transactions from the server.
  Future<Result<List<TransactionDto>, Exception>> fetchTransactions() async {
    try {
      final result = await apiService.get(remoteTransactionsFileUrl);
      if (result is Exception) {
        return Failure(result as DioException);
      }

      final response = (result as Success).value as Response<dynamic>;
      final data = response.data as Map<String, dynamic>;
      final dataTransaction = data['transactions'] as List<dynamic>;
      final transactions = dataTransaction
          .map((e) => TransactionDto.fromJson(e as Map<String, dynamic>))
          .toList();
      return Success(transactions);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
