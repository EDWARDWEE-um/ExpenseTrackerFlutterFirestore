import 'package:expensetracker/components/transactions/transaction_card.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/data/models/transaction_docid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late IncomeCubit _incomeCubit;
  late List<TransactionDocID> _incomeDocIDList;

  @override
  void initState() {
    super.initState();
    _incomeDocIDList = [];
    _incomeCubit = BlocProvider.of<IncomeCubit>(context);

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeCubit, IncomeState>(
      bloc: _incomeCubit,
      builder: (context, state) {
        if (state is IncomeUpdated) {
          final _income = state.income.reversed.toList();
          final _doc = state.documentID.reversed.toList();
            for (var i in _income) {
                  _incomeDocIDList.add(TransactionDocID(
                    docID: _doc[_income.indexOf(i)],
                    income: i,
                  ));
                }
          return StickyGroupedListView<TransactionDocID, DateTime>(
                  elements: _incomeDocIDList,
                  groupBy: (TransactionDocID income) => DateTime(income.income!.dateTime.year,
                      income.income!.dateTime.month, income.income!.dateTime.day),
                  groupSeparatorBuilder: (TransactionDocID income) => SizedBox(
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
                    documentId:income.docID,
                  ),
                  itemComparator: (TransactionDocID income1, TransactionDocID income2) =>
                      income1.income!.dateTime
                          .compareTo(income2.income!.dateTime), 
                  itemScrollController:
                      GroupedItemScrollController(), 
                  order: StickyGroupedListOrder.DESC, 
                  floatingHeader: false,
                  stickyHeaderBackgroundColor: Colors.white,
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
