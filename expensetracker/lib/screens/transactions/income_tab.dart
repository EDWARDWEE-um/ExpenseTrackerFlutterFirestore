import 'package:expensetracker/components/transactions/transaction_card.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/cubits/totalTransactions/income/total_income_cubit.dart';
import 'package:expensetracker/data/models/total_income/total_income.dart';
import 'package:expensetracker/data/models/transaction_docid/transaction_docid.dart';
import 'package:expensetracker/utils/swipe_card/swipe_card_condition.dart';
import 'package:expensetracker/utils/total_transaction/total_transactions_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class IncomeTab extends StatefulWidget {
  final ScrollController scrollController;
  const IncomeTab({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> {
  late List<TransactionDocID> _incomeDocIDList;

  @override
  void initState() {
    super.initState();
    _incomeDocIDList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      final _colorTheme = state.colorTheme;
      return Column(
        children: [
          Expanded(
            child: BlocBuilder<TotalIncomeCubit, TotalIncomeState>(
                builder: (context, state) {
              if (state is TotalIncomeUpdated) {
                final _totalIncome = state.totalIncome;
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
                                  index: index, totalIncome: _totalIncome)
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
            child: BlocBuilder<IncomeCubit, IncomeState>(
              builder: (context, state) {
                if (state is IncomeUpdated) {
                  final _income = state.income.reversed.toList();
                  final _doc = state.documentID.reversed.toList();
                  final _totalIncomeCalculation = TotalTransactionsCalculator(incomes: _income);
                  for (var i in _income) {
                    _incomeDocIDList.add(TransactionDocID(
                      docID: _doc[_income.indexOf(i)],
                      income: i,
                    ));
                  }
                  final _updatedTotalIncome = TotalIncome(
                    totalIncome: _totalIncomeCalculation.totalTransaction(),
                    totalDailyIncome:
                        _totalIncomeCalculation.totalDailyTransaction(),
                    totalWeeklyIncome:
                        _totalIncomeCalculation.totalWeeklyTransaction(),
                    totalMonthlyIncome:
                        _totalIncomeCalculation.totalMonthlyTransaction(),
                    totalYearlyIncome:
                        _totalIncomeCalculation.totalYearlyTransaction(),
                  );

                  BlocProvider.of<TotalIncomeCubit>(context)
                      .upsertTotalIncome(_updatedTotalIncome);

                  return StickyGroupedListView<TransactionDocID, DateTime>(
                    elements: _incomeDocIDList,
                    groupBy: (TransactionDocID income) => DateTime(
                        income.income!.dateTime.year,
                        income.income!.dateTime.month,
                        income.income!.dateTime.day),
                    groupSeparatorBuilder: (TransactionDocID income) =>
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
                              '${income.income!.dateTime.day}. ${income.income!.dateTime.month}, ${income.income!.dateTime.year}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, TransactionDocID income) =>
                        TransactionCard(
                      income: income.income,
                      documentId: income.docID,
                    ),
                    itemComparator:
                        (TransactionDocID income1, TransactionDocID income2) =>
                            income1.income!.dateTime
                                .compareTo(income2.income!.dateTime),
                    itemScrollController: GroupedItemScrollController(),
                    order: StickyGroupedListOrder.DESC,
                    floatingHeader: false,
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
