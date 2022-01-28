import 'package:expensetracker/components/commons/cards/transaction_card.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _incomeCubit = BlocProvider.of<IncomeCubit>(context);

    _scrollController = widget.scrollController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeCubit, IncomeState>(
      builder: (context, state) {
        if (state is IncomeUpdated) {
          final income = state.income;
          final doc = state.documentID;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: income.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionCard(
                  income: income[index],
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
