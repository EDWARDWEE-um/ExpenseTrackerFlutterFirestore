import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenseType/expense_type_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/cubits/incomeType/income_type_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTransactionDetail extends StatefulWidget {
  final Expense? expense;
  final Income? income;
  final String type;
  final TextTheme textTheme;
  final ColorTheme colorTheme;

  const CreateEditTransactionDetail({
    Key? key,
    this.expense,
    this.income,
    required this.type,
    required this.textTheme,
    required this.colorTheme,
  }) : super(key: key);

  @override
  _CreateEditTransactionDetailState createState() =>
      _CreateEditTransactionDetailState();
}

class _CreateEditTransactionDetailState
    extends State<CreateEditTransactionDetail> {
  final _formKey = GlobalKey<FormState>();
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final DateTime dateTime = DateTime.now();
  late TextEditingController _nameController, _amountController;
  late Expense _expense;
  late Income _income;
  late final String _type;
  late String _expenseTypeValue;
  late String _incomeTypeValue;
  late TextTheme _textTheme;
  late ColorTheme _colorTheme;

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
    _incomeTypeValue = 'Salary';
    _textTheme = widget.textTheme;
    _colorTheme = widget.colorTheme;
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: _textTheme.headline5,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 32.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: 'Enter name',
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
          (_type == 'Expense')
              ? BlocBuilder<ExpenseTypeCubit, ExpenseTypeState>(
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
                )
              : BlocBuilder<IncomeTypeCubit, IncomeTypeState>(
                  builder: (context, state) {
                    if (state is IncomeTypeUpdated) {
                      List<String> incomeType = state.incomeType;
                      return DropdownButton<String>(
                        value: _incomeTypeValue,
                        key: Key(_incomeTypeValue),
                        items: incomeType.map(
                          (e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _incomeTypeValue = newValue!;
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
                if (_type == 'Expense') {
                  _expense.name = _nameController.text;
                  _expense.amount = double.parse(_amountController.text);
                  _expense.type = _expenseTypeValue;
                } else {
                  _income.name = _nameController.text;
                  _income.amount = double.parse(_amountController.text);
                  _income.type = _incomeTypeValue;
                }
                setState(
                  () {
                    _formKey.currentState!.reset();
                    _nameController.clear();
                    _amountController.clear();
                    _expenseTypeValue = 'Bills (Credit Card)';
                    _incomeTypeValue = 'Salary';
                    if (_type == 'Expense') {
                      BlocProvider.of<ExpenseCubit>(context)
                          .addExpenses(_expense);
                    } else {
                      BlocProvider.of<IncomeCubit>(context).addIncomes(_income);
                    }
                  },
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
