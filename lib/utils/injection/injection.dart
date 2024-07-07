import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:personal_finance_app/utils/injection/injection.config.dart';

/// The service locator.
GetIt getIt = GetIt.instance;

/// Configures the dependencies.
@InjectableInit()
Future<void> configureDependencies(String env) async {
  getIt.init(environment: env);
}
