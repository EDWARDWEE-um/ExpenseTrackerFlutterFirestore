import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:expensetracker/screens/transactions/create_edit_transaction_page.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  final Expense? expense;
  final Income? income;
  final String documentId;
  const TransactionCard(
      {Key? key, this.expense, this.income, required this.documentId})
      : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  late Expense? _expense;
  late Income? _income;
  late String _documentId;
  dynamic _type;
  @override
  void initState() {
    super.initState();
    _expense = widget.expense;
    _income = widget.income;
    _documentId = widget.documentId;
    _type = (_expense != null) ? _expense : _income;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.white70, width: 1),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              Text(
                _type.name + _documentId,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          CreateEditTransactionPage.routeName,
          arguments: CreateEditTransactionPageArgs(
            expense: _expense,
            income: _income,
            documentId: _documentId,
          ),
        );
      },
    );
  }
}
