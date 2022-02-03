import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/total_expense.dart';
import 'package:expensetracker/services/repositories/total_expense_service_repository.dart';

part 'total_expense_state.dart';

class TotalExpenseCubit extends Cubit<TotalExpenseState> {
  final TotalExpenseServiceRepository totalExpenseServiceRepository;
 

  TotalExpenseCubit({required this.totalExpenseServiceRepository})
      : super(TotalExpenseInitial()) {
    getTotalExpenses();
  }

  void getTotalExpenses() async {
    emit(TotalExpenseLoading());
    DocumentSnapshot expenseList =
        await totalExpenseServiceRepository.getTotalExpense();
    Map<String,dynamic> json = expenseList.data() as Map<String,dynamic>;
    TotalExpense totalExpense = TotalExpense.fromJson(json);
    emit(TotalExpenseUpdated(totalExpense: totalExpense));
  }

  void upsertTotalExpenses(TotalExpense totalExpense) async {
    emit(TotalExpenseLoading());
    await totalExpenseServiceRepository.upsertTotalExpense(totalExpense);
    emit(TotalExpenseUpdated(totalExpense: totalExpense));
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
