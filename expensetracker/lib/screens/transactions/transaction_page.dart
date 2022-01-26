import 'package:expensetracker/components/commons/cards/expense_card.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  static const routeName = '/portfolio';
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseUpdated) {
          final expense = state.expense;
          final doc = state.documentID;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ...expense.map(
                    (e) => ExpenseCard(
                      expense: e,
                      documentId: doc[expense.indexOf(e)].toString(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        }
      },
    );
  }
}
