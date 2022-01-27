import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/commons/expenseType/expense_type_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTransactionDetail extends StatefulWidget {
  final Expense? expense;
  final Income? income;
  final String type;
  const CreateEditTransactionDetail(
      {Key? key, this.expense, this.income, required this.type})
      : super(key: key);

  @override
  _CreateEditTransactionDetailState createState() =>
      _CreateEditTransactionDetailState();
}

class _CreateEditTransactionDetailState
    extends State<CreateEditTransactionDetail> {
  final _formKey = GlobalKey<FormState>();
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final DateTime dateTime = DateTime.now();
  late TextEditingController _nameController,
      _amountController;
  late Expense _expense;
  late Income _income;
  late final String _type;
  late String _expenseTypeValue;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _type = widget.type;
    _expense = (widget.expense != null)
        ? widget.expense!
        : Expense(
            name: 'ALI',
            amount: 0,
            type: '',
            dateTime: dateTime,
            uid: uid,
          );
    _income = (widget.income != null)
        ? widget.income!
        : Income(
            name: '',
            amount: 0,
            type: '',
            dateTime: dateTime,
            uid: uid,
          );
    _expenseTypeValue = 'Bills (Credit Card)';
  }

  void _disposeControllers() {
    _nameController.dispose();
    _amountController.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (_type == 'Expense')
        ? BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state is ExpenseUpdated) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          child: Text('Name'),
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 32.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText: 'Name',
                          ),
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
                        BlocBuilder<ExpenseTypeCubit, ExpenseTypeState>(
                          builder: (context, state) {
                            if (state is ExpenseTypeUpdated) {
                              List<String> expenseType = state.expenseType;
                              return DropdownButton<String>(
                                value: _expenseTypeValue,
                                key: Key(_expenseTypeValue),
                                items: expenseType.map(
                                  (e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _expenseTypeValue = newValue!;
                                  });
                                },
                              );
                            } else {
                              return const CircularProgressIndicator(
                                color: Colors.black,
                              );
                            }
                          },
                        ),
                        PrimaryButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _expense.name = _nameController.text;
                              _expense.amount =
                                  double.parse(_amountController.text);
                              _expense.type = _expenseTypeValue;
                              setState(
                                () {
                                  _formKey.currentState!.reset();
                                  _nameController.clear();
                                  _amountController.clear();
                                  _expenseTypeValue = 'Bills (Credit Card)';
                                  BlocProvider.of<ExpenseCubit>(context)
                                      .addExpenses(_expense);
                                },
                              );
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator(
                  color: Colors.black,
                );
              }
            },
          )
        : BlocBuilder<IncomeCubit, IncomeState>(
            builder: (context, state) {
              if (state is IncomeUpdated) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          child: Text('Name'),
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 32.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText: 'Name',
                          ),
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
                        PrimaryButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _income.name = _nameController.text;
                              _income.amount =
                                  double.parse(_amountController.text);
                              _income.type = '';
                              setState(() {
                                _formKey.currentState!.reset();
                                _nameController.clear();
                                BlocProvider.of<IncomeCubit>(context)
                                    .addIncomes(_income);
                              });
                            }
                          },
                        ),
                      ],
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
