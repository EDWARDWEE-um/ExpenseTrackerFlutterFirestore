import 'package:expensetracker/components/transactions/transaction_detail.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:flutter/material.dart';

class CreateEditTransactionPageArgs {
  final Expense? expense;
  final Income? income;

  CreateEditTransactionPageArgs({this.expense, this.income});
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
  late String _categoryDropDownValue;
  late bool _isUpdate;

  @override
  void initState() {
    super.initState();
    _categoryDropDownValue = _categoryType[0];
    _expense = widget.args.expense;
    _income = widget.args.income; 
    _isUpdate = (_expense != null) || (_income != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _isUpdate? const Text('Update') : const Text('Category'),
          DropdownButton<String>(
            value: _categoryDropDownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _categoryDropDownValue = newValue!;
              });
            },
            items: _categoryType.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          CreateEditTransactionDetail(
            type: _categoryDropDownValue,
            key: ValueKey(_categoryDropDownValue),
          ),
        ],
      ),
    );
  }
}
