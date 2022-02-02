import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expensetracker/components/transactions/transaction_detail.dart';
import 'package:expensetracker/constants/dimen_constants.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:expensetracker/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditTransactionPageArgs {
  final Expense? expense;
  final Income? income;
  final String? documentId;

  CreateEditTransactionPageArgs({this.expense, this.income, this.documentId});
}

class CreateEditTransactionPage extends StatefulWidget {
  static const routeName = '/createEditTransaction';
  final CreateEditTransactionPageArgs args;

  const CreateEditTransactionPage(this.args, {Key? key}) : super(key: key);

  @override
  _CreateEditTransactionPageState createState() =>
      _CreateEditTransactionPageState();
}

class _CreateEditTransactionPageState extends State<CreateEditTransactionPage> {
  final List<String> _categoryType = [
    'Expense',
    'Income',
  ];

  late Expense? _expense;
  late Income? _income;
  late String? _documentId;
  late String _categoryDropDownValue;
  late bool _isUpdate;

  @override
  void initState() {
    super.initState();
    _expense = widget.args.expense;
    _income = widget.args.income;
    _documentId = widget.args.documentId;
    _isUpdate = (_expense != null) || (_income != null);
    _categoryDropDownValue =
        (_isUpdate && (_income != null)) ? _categoryType[1] : _categoryType[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
          final _colorTheme = state.colorTheme;
          return IconButton(
            icon: Icon(Icons.arrow_back, color: _colorTheme.onBackgroundColor),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false,
                arguments: const HomePageArgs(pageIndex: 2)),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final textTheme = themeState.themeData.textTheme;
            final colorTheme = themeState.colorTheme;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _isUpdate
                        ? [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Edit Details',
                                  style: textTheme.headline3,
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.delete,
                                    color: colorTheme.onBackgroundColor,
                                  ),
                                  onLongPress: () {
                                    setState(
                                      () {
                                        if (_expense != null) {
                                          BlocProvider.of<ExpenseCubit>(context)
                                              .deleteExpenses(
                                            _documentId!,
                                          );
                                          Navigator.pushReplacementNamed(
                                            context,
                                            HomePage.routeName,
                                            arguments: const HomePageArgs(
                                              pageIndex: 2,
                                            ),
                                          );
                                        }
                                        if (_income != null) {
                                          BlocProvider.of<IncomeCubit>(context)
                                              .deleteIncomes(
                                            _documentId!,
                                          );
                                          Navigator.pushReplacementNamed(
                                            context,
                                            HomePage.routeName,
                                            arguments: const HomePageArgs(
                                              pageIndex: 2,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: DropdownButtonFormField2<String>(
                                decoration: InputDecoration(
                                  fillColor: colorTheme.onBackgroundColor
                                      .withOpacity(opacityMin),
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      midRadius,
                                    ),
                                    borderSide: BorderSide(
                                      color: colorTheme.onPrimaryColor,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                buttonPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                dropdownDecoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorTheme.onPrimaryColor
                                          .withOpacity(opacityMin)),
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                  color: colorTheme.backgroundColor,
                                ),
                                hint: const Text('select category'),
                                buttonHeight: dropdownButtonSize,
                                value: _categoryDropDownValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: textTheme.subtitle1,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _categoryDropDownValue = newValue!;
                                  });
                                },
                                items: _categoryType
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]
                        : [
                            Text(
                              'Create Transaction',
                              style: textTheme.headline3,
                            ),
                            const SizedBox(
                              height: spaceLarge,
                            ),
                            Text(
                              'Category',
                              style: textTheme.headline5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: DropdownButtonFormField2<String>(
                                decoration: InputDecoration(
                                  fillColor: colorTheme.onBackgroundColor
                                      .withOpacity(opacityMin),
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      midRadius,
                                    ),
                                    borderSide: BorderSide(
                                      color: colorTheme.onPrimaryColor,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                buttonPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                dropdownDecoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorTheme.onPrimaryColor
                                          .withOpacity(opacityMin)),
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                  color: colorTheme.backgroundColor,
                                ),
                                hint: const Text('select category'),
                                buttonHeight: dropdownButtonSize,
                                value: _categoryDropDownValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: textTheme.subtitle1,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _categoryDropDownValue = newValue!;
                                  });
                                },
                                items: _categoryType
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                  ),
                  CreateEditTransactionDetail(
                    documentID: _documentId ?? '',
                    expense: _expense,
                    income: _income,
                    isUpdate: _isUpdate,
                    textTheme: textTheme,
                    colorTheme: colorTheme,
                    type: _categoryDropDownValue,
                    key: ValueKey(_categoryDropDownValue),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
