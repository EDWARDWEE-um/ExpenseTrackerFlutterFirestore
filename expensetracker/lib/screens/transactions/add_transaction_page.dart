import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionPage extends StatefulWidget {
  static const routeName = '/addTransaction';

  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  late TextEditingController _nameController,
      _typeController,
      _amountController;
  late ExpenseCubit _expenseCubit;
  late Expense _expense;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _expenseCubit =
        ExpenseCubit(expenseServiceRepository: ExpenseServiceRepository());
    _nameController = TextEditingController();
    _typeController = TextEditingController();
    _amountController = TextEditingController();
    _expense = Expense(
      name: '',
      amount: 0,
      type: '',
      dateTime: DateTime.now(),
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
  }

  void _disposeControllers() {
    _nameController.dispose();
    _typeController.dispose();
    _amountController.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        bloc: _expenseCubit,
        builder: (context, state) {
          if (state is ExpenseUpdated) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _typeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  PrimaryButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _expense.name = _nameController.text;
                        _expense.amount = double.parse(_amountController.text);
                        _expense.type = _typeController.text;
                        debugPrint(_nameController.text);
                        debugPrint(_amountController.text);
                        debugPrint(_typeController.text);
                        setState(() {
                          _formKey.currentState!.reset();
                          _nameController.clear();
                          BlocProvider.of<ExpenseCubit>(context)
                              .addExpenses(_expense);
                        });
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}
