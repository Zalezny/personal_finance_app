import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_app/core/providers/transactions_notifier.dart';
import 'package:personal_finance_app/ui/screens/home/widgets/floating_action_section.dart';
import 'package:personal_finance_app/ui/screens/home/widgets/header_section.dart';
import 'package:personal_finance_app/ui/screens/home/widgets/table_section.dart';
import 'package:personal_finance_app/utils/logs/logger.dart';

/// Routing for the HomeScreen
abstract class HomeScreenRouting {
  /// Path for the router
  static const String routePath = '/';

  /// Builder for navigation to screen
  static PageRoute<T> buildRoute<T>({
    RouteSettings? settings,
  }) {
    Logger.log(HomeScreen);
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => const HomeScreen(),
      settings: settings,
    ) as PageRoute<T>;
  }
}

/// Home Screen for the personal finance app
class HomeScreen extends ConsumerWidget {
  /// Creates the HomeScreen
  const HomeScreen({super.key});

  /// The vertical padding for the screen between elements
  static const double verticalPadding = 30;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsNotifier =
        ref.watch(transactionsNotifierProvider.notifier);
    final transactions = ref.watch(transactionsNotifierProvider);

    return Scaffold(
      floatingActionButton: FloatingActionSection(
        transactionsNotifier: transactionsNotifier,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderSection(
                  balance: transactionsNotifier.getTotalAmount(),
                  verticalPadding: verticalPadding,
                ),
                TableSection(
                  transactions: transactions,
                  verticalPadding: verticalPadding,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
