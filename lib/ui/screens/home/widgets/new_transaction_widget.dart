import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_finance_app/utils/const/transaction_keys.dart';
import 'package:personal_finance_app/utils/extensions/datetime_extension.dart';
import 'package:personal_finance_app/utils/extensions/l10n_extension.dart';
import 'package:personal_finance_app/utils/extensions/routing_extension.dart';
import 'package:personal_finance_app/utils/types/transaction_type.dart';

/// A widget that displays a dialog to add a new transaction.
class NewTransactionWidget extends StatefulWidget {
  /// Creates the NewTransactionWidget
  const NewTransactionWidget({
    required this.onAdded,
    super.key,
  });

  /// The function to call when a transaction is added
  final void Function(DateTime, String, double, TransactionType) onAdded;

  @override
  State<NewTransactionWidget> createState() => _NewTransactionWidgetState();
}

class _NewTransactionWidgetState extends State<NewTransactionWidget> {
  final formKey = GlobalKey<FormState>();
  String title = '';
  double amount = 0;
  TransactionType type = TransactionType.expense;
  DateTime date = DateTime.now().withoutTime;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(context.l10n.addTransactionTitle),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                key: TransactionKeys.titleInputField,
                decoration:
                    InputDecoration(labelText: context.l10n.titleInputField),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.invalidTitle;
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                key: TransactionKeys.amountInputField,
                decoration:
                    InputDecoration(labelText: context.l10n.amountInputField),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.invalidAmount;
                  }
                  if (double.tryParse(value) == null) {
                    return context.l10n.invalidNumber;
                  }
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  ),
                ],
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  if (value != null) {
                    amount = double.parse(value);
                  }
                },
              ),
              DropdownButtonFormField<TransactionType>(
                key: TransactionKeys.typeInputField,
                decoration: InputDecoration(
                  labelText: context.l10n.typeInputField,
                ),
                value: type,
                items: TransactionType.values.map((TransactionType value) {
                  return DropdownMenuItem<TransactionType>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (TransactionType? newValue) {
                  type = newValue!;
                },
              ),
              ElevatedButton(
                key: TransactionKeys.dateInputField,
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().withoutTime,
                  );
                  if (pickedDate != null) {
                    date = pickedDate;
                  }
                },
                child: Text(context.l10n.dateInputField),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(context.l10n.cancelButton),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(context.l10n.addButton),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                widget.onAdded(
                  date,
                  title,
                  amount,
                  type,
                );
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
