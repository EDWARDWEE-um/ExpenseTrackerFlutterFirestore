import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/expense/expense_cubit.dart';
import 'package:expensetracker/data/models/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailPage extends StatefulWidget {
  final Expense expense;
  final String docId;
  const TransactionDetailPage(
      {Key? key, required this.expense, required this.docId})
      : super(key: key);

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  late Expense expenseDetails;
  late String documentID;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    expenseDetails = widget.expense;
    documentID = widget.docId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'This is the next page ' + expenseDetails.name,
              style: const TextStyle(fontSize: 24),
            ),
            PrimaryButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(
                  () {
                    BlocProvider.of<ExpenseCubit>(context)
                        .deleteExpenses(documentID);
                  },
                );
                Navigator.pop(context);
              },
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            PrimaryButton(child: const Text('Submit'), onPressed: () {
              if(_formKey.currentState!.validate()){
                setState(() {
                  _formKey.currentState!.reset();
                  nameController.clear();
                });
              }
            }),
          ],
        ),
      ),
    );
  }
}
