import 'package:expensetracker/components/commons/cards/transaction_card.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseTab extends StatefulWidget {
  final ScrollController scrollController;
  const ExpenseTab({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  late ExpenseCubit _expenseCubit;

  @override
  void initState() {
    super.initState();

    _expenseCubit = BlocProvider.of<ExpenseCubit>(context);

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      bloc: _expenseCubit,
      builder: (context, state) {
        if (state is ExpenseUpdated) {
          final expense = state.expense.reversed.toList();
          final doc = state.documentID.reversed.toList();
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              key: Key(expense.length.toString()),
              itemCount: expense.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionCard(
                  expense: expense[index],
                  documentId: doc[index],
                );
              },
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
