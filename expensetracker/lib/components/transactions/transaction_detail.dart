import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expensetracker/components/commons/buttons/buttons.dart';
import 'package:expensetracker/constants/dimen_constants.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenseType/expense_type_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/cubits/incomeType/income_type_cubit.dart';
import 'package:expensetracker/data/models/expense/expense.dart';
import 'package:expensetracker/data/models/income/income.dart';
import 'package:expensetracker/screens/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTransactionDetail extends StatefulWidget {
  final Expense? expense;
  final Income? income;
  final String type;
  final TextTheme textTheme;
  final ColorTheme colorTheme;
  final bool isUpdate;
  final String documentID;

  const CreateEditTransactionDetail({
    Key? key,
    this.expense,
    this.income,
    required this.documentID,
    required this.type,
    required this.textTheme,
    required this.colorTheme,
    required this.isUpdate,
  }) : super(key: key);

  @override
  _CreateEditTransactionDetailState createState() =>
      _CreateEditTransactionDetailState();
}

class _CreateEditTransactionDetailState
    extends State<CreateEditTransactionDetail> {
  final _formKey = GlobalKey<FormState>();
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late DateTime dateTime;
  late TextEditingController _nameController, _amountController;
  late Expense _expense;
  late Income _income;
  late final String _documentID;
  late final String _type;
  late String _expenseTypeValue;
  late String _incomeTypeValue;
  late TextTheme _textTheme;
  late ColorTheme _colorTheme;
  late bool _isUpdate;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _type = widget.type;
    _isUpdate = widget.isUpdate;
    _expense = (_isUpdate && (widget.expense != null))
        ? widget.expense!
        : Expense(
            name: '',
            amount: 0,
            type: '',
            dateTime: dateTime,
            uid: uid,
          );
    _income = (_isUpdate && (widget.income != null))
        ? widget.income!
        : Income(
            name: '',
            amount: 0,
            type: '',
            dateTime: dateTime,
            uid: uid,
          );
    _documentID = (_isUpdate) ? widget.documentID : '';
    _expenseTypeValue = (_isUpdate) ? _expense.type : 'Bills (Credit Card)';
    _incomeTypeValue = (_isUpdate) ? _income.type : 'Salary';
    _nameController.value = (_isUpdate && (_expense.name != ''))
        ? TextEditingValue(text: _expense.name)
        : ((_income.name != '')
            ? TextEditingValue(text: _income.name)
            : TextEditingValue.empty);
    _amountController.value = (_isUpdate && (_expense.amount != 0))
        ? TextEditingValue(
            text: _expense.amount.toString(),
          )
        : ((_income.amount != 0)
            ? TextEditingValue(
                text: _income.amount.toString(),
              )
            : TextEditingValue.empty);
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              fillColor: _colorTheme.onBackgroundColor.withOpacity(opacityMin),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 32.0,
                ),
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
          const SizedBox(
            height: 20,
          ),
          Text(
            'Amount',
            style: _textTheme.headline5,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              fillColor: _colorTheme.onBackgroundColor.withOpacity(opacityMin),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 32.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: 'Enter Amount',
            ),
            controller: _amountController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter amount';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Type',
            style: _textTheme.headline5,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          (_type == 'Expense')
              ? BlocBuilder<ExpenseTypeCubit, ExpenseTypeState>(
                  builder: (context, state) {
                    if (state is ExpenseTypeUpdated) {
                      List<String> expenseType = state.expenseType;
                      return DropdownButtonFormField2<String>(
                        decoration: InputDecoration(
                          fillColor: _colorTheme.onBackgroundColor
                              .withOpacity(opacityMin),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              midRadius,
                            ),
                            borderSide: BorderSide(
                              color: _colorTheme.onPrimaryColor,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        buttonPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        dropdownDecoration: BoxDecoration(
                          border: Border.all(
                              color: _colorTheme.onPrimaryColor
                                  .withOpacity(opacityMin)),
                          borderRadius: BorderRadius.circular(defaultRadius),
                          color: _colorTheme.backgroundColor,
                        ),
                        hint: const Text('select category'),
                        buttonHeight: dropdownButtonSize,
                        value: _expenseTypeValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: _textTheme.subtitle1,
                        onChanged: (String? newValue) {
                          setState(() {
                            _expenseTypeValue = newValue!;
                          });
                        },
                        items: expenseType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                      return DropdownButtonFormField2<String>(
                        decoration: InputDecoration(
                          fillColor: _colorTheme.onBackgroundColor
                              .withOpacity(opacityMin),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              midRadius,
                            ),
                            borderSide: BorderSide(
                              color: _colorTheme.onPrimaryColor,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        buttonPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        dropdownDecoration: BoxDecoration(
                          border: Border.all(
                              color: _colorTheme.onPrimaryColor
                                  .withOpacity(opacityMin)),
                          borderRadius: BorderRadius.circular(defaultRadius),
                          color: _colorTheme.backgroundColor,
                        ),
                        hint: const Text('select category'),
                        buttonHeight: dropdownButtonSize,
                        value: _incomeTypeValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: _textTheme.subtitle1,
                        onChanged: (String? newValue) {
                          setState(() {
                            _incomeTypeValue = newValue!;
                          });
                        },
                        items: incomeType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.black,
                      );
                    }
                  },
                ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
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
                    dateTime = DateTime.now();
                    if (_type == 'Expense') {
                      if (_isUpdate) {
                        BlocProvider.of<ExpenseCubit>(context).updateExpenses(
                          expense: _expense,
                          id: _documentID,
                        );
                      } else {
                        BlocProvider.of<ExpenseCubit>(context)
                            .addExpenses(_expense);
                      }
                    } else {
                      if (_isUpdate) {
                        BlocProvider.of<IncomeCubit>(context)
                            .updateIncome(income: _income, id: _documentID);
                      } else {
                        BlocProvider.of<IncomeCubit>(context)
                            .addIncomes(_income);
                      }
                    }
                  },
                );
                Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false, arguments:  const HomePageArgs(pageIndex: 2));
              }
            },
          ),
        ],
      ),
    );
  }
}
