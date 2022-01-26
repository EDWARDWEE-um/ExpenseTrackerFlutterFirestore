import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/screens/transactions/transaction_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        Expense expenseData = Expense(
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: 'Ali',
          amount: 500,
          dateTime: DateTime.now(),
          type: 'SHARE',
        );
        if (state is ExpenseUpdated) {
          final expense = state.expense;
          final doc = state.documentID;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: expense
                    .map(
                      (e) => InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Row(
                              children: [
                                Text(
                                  e.name + doc[expense.indexOf(e)].toString(),
                                ),
                                PrimaryButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        BlocProvider.of<ExpenseCubit>(context)
                                            .deleteExpenses(
                                          doc[expense.indexOf(e)].toString(),
                                        );
                                      },
                                    );
                                  },
                                ),
                                PrimaryButton(
                                  child: const Text('Add'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        BlocProvider.of<ExpenseCubit>(context)
                                            .addExpenses(expenseData);
                                      },
                                    );
                                  },
                                ),
                                PrimaryButton(
                                  child: const Text('Update'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        BlocProvider.of<ExpenseCubit>(context)
                                            .updateExpenses(
                                          doc[expense.indexOf(e)].toString(),
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
                                expense: e,
                                docId: doc[expense.indexOf(e)],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
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
