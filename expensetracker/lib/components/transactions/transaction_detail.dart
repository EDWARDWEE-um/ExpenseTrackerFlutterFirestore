import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';
import 'package:expensetracker/services/repositories/income_service_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTransactionDetail extends StatefulWidget {
  final Expense ? expense;
  final Income ? income;
  final String type;
  const CreateEditTransactionDetail({Key? key, this.expense, this.income, required this.type}) : super(key: key);

  @override
  _CreateEditTransactionDetailState createState() => _CreateEditTransactionDetailState();
}

class _CreateEditTransactionDetailState extends State<CreateEditTransactionDetail> {
  final _formKey = GlobalKey<FormState>();
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final DateTime dateTime = DateTime.now();
  late TextEditingController _nameController,
      _typeController,
      _amountController;
  late ExpenseCubit _expenseCubit;
  late IncomeCubit _incomeCubit;
  late Expense _expense;
  late Income _income;
  late final String _type;
  
  @override
  void initState() {
    super.initState();
    _expenseCubit =
        ExpenseCubit(expenseServiceRepository: ExpenseServiceRepository());
    _incomeCubit = IncomeCubit(incomeServiceRepository: IncomeServiceRepository());
    _nameController = TextEditingController();
    _typeController = TextEditingController();
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
    debugPrint(_type);
   return (_type=='Expense') ? BlocBuilder<ExpenseCubit, ExpenseState>(
                      bloc: _expenseCubit,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                        _expense.amount = double.parse(
                                            _amountController.text);
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
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.black,
                          );
                        }
                      },
                    ) : BlocBuilder<IncomeCubit, IncomeState>(
                      bloc: _incomeCubit,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                        _income.name = _nameController.text;
                                        _income.amount = double.parse(
                                            _amountController.text);
                                        _income.type = _typeController.text;
                                        debugPrint(_nameController.text);
                                        debugPrint(_amountController.text);
                                        debugPrint(_typeController.text);
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