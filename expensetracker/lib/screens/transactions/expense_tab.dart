import 'package:expensetracker/components/transactions/transaction_card.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/totalTransactions/expense/total_expense_cubit.dart';
import 'package:expensetracker/data/models/transaction_docid/transaction_docid.dart';
import 'package:expensetracker/data/models/total_expense/total_expense.dart';
import 'package:expensetracker/utils/swipe_card/swipe_card_condition.dart';
import 'package:expensetracker/utils/total_transaction/total_transactions_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
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
  late List<TransactionDocID> _expenseDocIDList;

  @override
  void initState() {
    super.initState();
    _expenseDocIDList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      final _colorTheme = state.colorTheme;
      return Column(
        children: [
          Expanded(
            child: BlocBuilder<TotalExpenseCubit, TotalExpenseState>(
                builder: (context, state) {
              if (state is TotalExpenseUpdated) {
                final _totalExpense = state.totalExpense;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Swiper(
                    layout: SwiperLayout.DEFAULT,
                    pagination: const SwiperPagination(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.grey,
                        child: Text(
                          SwipeCardCondition(
                                  index: index, totalExpense: _totalExpense)
                              .getSwipeCard(),
                        ),
                      );
                    },
                    itemCount: 5,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                );
              } else {
                return const CircularProgressIndicator(
                  color: Colors.black,
                );
              }
            }),
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseUpdated) {
                  final _expense = state.expense.reversed.toList();
                  final _doc = state.documentID.reversed.toList();
                  final _totalExpenseCalculation =
                      TotalTransactionsCalculator(expenses: _expense);
                  for (var e in _expense) {
                    _expenseDocIDList.add(TransactionDocID(
                      docID: _doc[_expense.indexOf(e)],
                      expense: e,
                    ));
                  }

                  final _updatedTotalExpense = TotalExpense(
                    totalExpense: _totalExpenseCalculation.totalTransaction(),
                    totalDailyExpense:
                        _totalExpenseCalculation.totalDailyTransaction(),
                    totalWeeklyExpense:
                        _totalExpenseCalculation.totalWeeklyTransaction(),
                    totalMonthlyExpense:
                        _totalExpenseCalculation.totalMonthlyTransaction(),
                    totalYearlyExpense:
                        _totalExpenseCalculation.totalYearlyTransaction(),
                  );

                  BlocProvider.of<TotalExpenseCubit>(context)
                      .upsertTotalExpenses(_updatedTotalExpense);

                  return StickyGroupedListView<TransactionDocID, DateTime>(
                    elements: _expenseDocIDList,
                    groupBy: (TransactionDocID expense) => DateTime(
                        expense.expense!.dateTime.year,
                        expense.expense!.dateTime.month,
                        expense.expense!.dateTime.day),
                    groupSeparatorBuilder: (TransactionDocID expense) =>
                        SizedBox(
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
                              '${expense.expense!.dateTime.day}. ${expense.expense!.dateTime.month}, ${expense.expense!.dateTime.year}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, TransactionDocID expense) =>
                        TransactionCard(
                      expense: expense.expense,
                      documentId: expense.docID,
                    ),
                    itemComparator: (TransactionDocID expense1,
                            TransactionDocID expense2) =>
                        expense1.expense!.dateTime
                            .compareTo(expense2.expense!.dateTime),
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
