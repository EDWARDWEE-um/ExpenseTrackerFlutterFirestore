import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/screens/transactions/transaction_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCard extends StatefulWidget {
  final Expense expense;
  final String documentId;
  const ExpenseCard(
      {Key? key, required this.expense, required this.documentId})
      : super(key: key);

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  late Expense _expense;
  late String _documentId;
  @override
  void initState() {
    super.initState();
    _expense = widget.expense;
    _documentId = widget.documentId;
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
                _expense.name + _documentId,
              ),
              PrimaryButton(
                child: const Text('Delete'),
                onPressed: () {
                  setState(
                    () {
                      BlocProvider.of<ExpenseCubit>(context).deleteExpenses(
                        _documentId,
                      );
                    },
                  );
                },
              ),
              PrimaryButton(
                child: const Text('Update'),
                onPressed: () {
                  setState(
                    () {
                      BlocProvider.of<ExpenseCubit>(context).updateExpenses(
                        _documentId,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              expense: _expense,
              docId: _documentId,
            ),
          ),
        );
      },
    );
  }
}
