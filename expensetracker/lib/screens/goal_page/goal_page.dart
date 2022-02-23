import 'package:expensetracker/components/transactions/transaction_card.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expense/expense_cubit.dart';
import 'package:expensetracker/data/models/expense/expense.dart';
import 'package:expensetracker/utils/total_transaction/total_transactions_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class GoalPage extends StatefulWidget {
  static const routeName = '/goal';
  const GoalPage({
    Key? key,
  }) : super(key: key);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      final _textTheme = state.themeData.textTheme;
      final _colorTheme = state.colorTheme;
      return Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
              },
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
                      Text('Create A Goal'),
                    ],
                  ),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            flex: 4,
            child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseUpdated) {
                  final _expense = state.expense.reversed.toList();
                  final _doc = state.documentID.reversed.toList();
                  final _totalExpenseCalculation =
                      TotalTransactionsCalculator(expenses: _expense);

                  return StickyGroupedListView<Expense, DateTime>(
                    elements: _expense,
                    groupBy: (Expense expense) => DateTime(
                        expense.dateTime.year,
                        expense.dateTime.month,
                        expense.dateTime.day),
                    groupSeparatorBuilder: (Expense expense) => SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            border: Border.all(
                              color: Colors.blue[300]!,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${expense.dateTime.day}. ${expense.dateTime.month}, ${expense.dateTime.year}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, Expense expense) => TransactionCard(
                      expense: expense,
                      documentId: '1',
                    ),
                    itemComparator: (Expense expense1, Expense expense2) =>
                        expense1.dateTime.compareTo(expense2.dateTime),
                    itemScrollController: GroupedItemScrollController(),
                    order: StickyGroupedListOrder.DESC,
                    stickyHeaderBackgroundColor: _colorTheme.backgroundColor,
                  );
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
