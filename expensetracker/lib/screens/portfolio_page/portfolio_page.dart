import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/services/database.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';
import 'package:expensetracker/services/repositories/user_service_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense.dart';

class PortfolioPage extends StatefulWidget {
  static const routeName = '/portfolio';

  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String? user = FirebaseAuth.instance.currentUser!.photoURL;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseUpdated) {
          Expense expense = Expense(
              uid: FirebaseAuth.instance.currentUser!.uid,
              name: 'Netflix',
              amount: 500,
              dateTime: DateTime.now(),
              type: 'entertainment');
          return InkWell(
            child: Text('dfs'),
            onTap: () {
              setState(() {
                BlocProvider.of<ExpenseCubit>(context).addExpenses(expense);
              });
            },
          );
        } else {
          return Text('data');
        }
      },
    );
  }
}
