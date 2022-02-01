import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/total_expense.dart';
import 'package:expensetracker/services/repositories/total_expense_service_repository.dart';

part 'total_expense_state.dart';

class TotalExpenseCubit extends Cubit<TotalExpenseState> {
  final TotalExpenseServiceRepository totalExpenseServiceRepository;
  final List<TotalExpense> totalExpenses = [];

  TotalExpenseCubit({required this.totalExpenseServiceRepository})
      : super(TotalExpenseInitial()) {
    //getExpenses();
  }

  // void getExpenses() async {
  //   emit(ExpenseLoading());
  //   QuerySnapshot expenseList = await expenseServiceRepository.getExpenses();
  //   for (int i = 0; i < expenseList.docs.length; i++) {
  //     Map<String, dynamic> expenseMap =
  //         expenseList.docs[i].data() as Map<String, dynamic>;
  //     if (!documentID.contains(expenseList.docs[i].id)) {
  //       expenses.add(Expense.fromJson(expenseMap));
  //       documentID.add(expenseList.docs[i].id);
  //     }
  //   }
  //   emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  // }

  void addTotalExpenses(TotalExpense totalExpense) async {
    emit(TotalExpenseLoading());
    await totalExpenseServiceRepository.addTotalExpense(totalExpense);
    totalExpenses.add(totalExpense);
    emit(TotalExpenseUpdated(totalExpense: totalExpenses));
  }

  // void deleteExpenses(String id) async {
  //   emit(ExpenseLoading());
  //   expenseServiceRepository.deleteExpenses(docId: id);
  //   final int index = documentID.indexWhere((element) => element == id);
  //   expenses.remove(expenses.elementAt(index));
  //   documentID.remove(id);
  //   emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  // }

  // void updateExpenses({
  //   required String id,
  //   required Expense expense,
  // }) async {
  //   emit(ExpenseLoading());

  //   expenseServiceRepository.updateExpenses(docId: id, expense: expense);
  //   for (int i = 0; i < documentID.length; i++) {
  //     if (documentID[i] == id) {
  //       expenses.elementAt(i).name = expense.name;
  //       expenses.elementAt(i).amount = expense.amount;
  //       expenses.elementAt(i).type = expense.type;
  //     }
  //   }
  //   emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  // }
}