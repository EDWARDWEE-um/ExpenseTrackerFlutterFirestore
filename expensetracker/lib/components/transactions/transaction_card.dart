import 'package:expensetracker/data/models/expense/expense.dart';
import 'package:expensetracker/data/models/income/income.dart';
import 'package:expensetracker/screens/transactions/create_edit_transaction_page.dart';
import 'package:expensetracker/utils/icon_url/icon_url.dart';
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
    IconUrl detail = IconUrl();

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    detail.imgUrl(_type.type),
                    height: 60,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _type.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      _type.type,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  _type.amount.toString() + "\$",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
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
