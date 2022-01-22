import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseServiceRepository expenseServiceRepository;

  ExpenseCubit({required this.expenseServiceRepository})
      : super(ExpenseInitial()) {
    getExpenses();
  }

  void getExpenses() async {
    emit(ExpenseLoading());
    final expense = await expenseServiceRepository.getExpense();
    emit(ExpenseUpdated(expense: expense));
  }

  void addExpenses(Expense expense) async {
    emit(ExpenseLoading());
    final expenses = await expenseServiceRepository.addNewExpense(expense);
    emit(ExpenseUpdated(expense: expense));
  }
}
