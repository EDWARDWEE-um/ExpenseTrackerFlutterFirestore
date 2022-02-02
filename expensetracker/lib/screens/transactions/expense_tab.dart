import 'package:expensetracker/components/transactions/transaction_card.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/totalTransactions/expense/total_expense_cubit.dart';
import 'package:expensetracker/data/models/transaction_docid.dart';
import 'package:expensetracker/data/models/total_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

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
  late List<TransactionDocID> _expenseDocIDList;

  @override
  void initState() {
    super.initState();
    _expenseDocIDList = [];
    _expenseCubit = BlocProvider.of<ExpenseCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: BlocBuilder<TotalExpenseCubit, TotalExpenseState>(
              builder: (context, state) {
            TotalExpense _totalExpense = TotalExpense(
              totalExpense: 50,
              totalDailyExpense: 20,
              totalMonthlyExpense: 20,
              totalWeeklyExpense: 20,
              totalYearlyExpense: 40,
            );
            return InkWell(
              onTap: () {
                setState(() {
                  BlocProvider.of<TotalExpenseCubit>(context)
                      .addTotalExpenses(_totalExpense);
                });
              },
              child: const Card(
                child: Text('asdasd'),
              ),
            );
          }),
          flex: 1,
        ),
        Expanded(
          flex: 3,
          child: BlocBuilder<ExpenseCubit, ExpenseState>(
            bloc: _expenseCubit,
            builder: (context, state) {
              if (state is ExpenseUpdated) {
                final _expense = state.expense.reversed.toList();
                final _doc = state.documentID.reversed.toList();
                for (var e in _expense) {
                  _expenseDocIDList.add(TransactionDocID(
                    docID: _doc[_expense.indexOf(e)],
                    expense: e,
                  ));
                }
                return StickyGroupedListView<TransactionDocID, DateTime>(
                  elements: _expenseDocIDList,
                  groupBy: (TransactionDocID expense) => DateTime(expense.expense!.dateTime.year,
                      expense.expense!.dateTime.month, expense.expense!.dateTime.day),
                  groupSeparatorBuilder: (TransactionDocID expense) => SizedBox(
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
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${expense.expense!.dateTime.day}. ${expense.expense!.dateTime.month}, ${expense.expense!.dateTime.year}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  indexedItemBuilder: (context, TransactionDocID expense, index) =>
                      TransactionCard(
                    expense: expense.expense,
                    documentId:expense.docID,
                  ),
                  itemComparator: (TransactionDocID expense1, TransactionDocID expense2) =>
                      expense1.expense!.dateTime
                          .compareTo(expense2.expense!.dateTime), // optional
                  itemScrollController:
                      GroupedItemScrollController(), // optional
                  order: StickyGroupedListOrder.DESC, // optional
                );
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: ListView.builder(
                //     key: Key(expense.length.toString()),
                //     itemCount: expense.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return TransactionCard(
                //         expense: expense[index],
                //         documentId: doc[index],
                //       );
                //     },
                //   ),
                // );
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
  }
}
