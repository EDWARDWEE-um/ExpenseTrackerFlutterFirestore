import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';
import 'package:flutter/material.dart';
part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseServiceRepository expenseServiceRepository;
  final List<Expense> expenses = [];
  final List documentID = [];

  ExpenseCubit({required this.expenseServiceRepository})
      : super(ExpenseInitial()) {
    getExpenses();
  }

  void getExpenses() async {
    emit(ExpenseLoading());
    QuerySnapshot expenseList = await expenseServiceRepository.getExpenses();
    for (int i = 0; i < expenseList.docs.length; i++) {
      Map<String, dynamic> expenseMap =
          expenseList.docs[i].data() as Map<String, dynamic>;
      if (!documentID.contains(expenseList.docs[i].id)) {
        expenses.add(Expense.fromJson(expenseMap));
        documentID.add(expenseList.docs[i].id);
      }
    }
    emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  }

  void addExpenses(Expense expense) async {
    emit(ExpenseLoading());
    String docID = await expenseServiceRepository.addNewExpense(expense);
    expenses.add(expense);
    documentID.add(docID);
    debugPrint(expenses.last.name);
    debugPrint(documentID.toString());
    emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  }

  void deleteExpenses(String id) async {
    emit(ExpenseLoading());
    expenseServiceRepository.deleteExpenses(docId: id);
    final int index = documentID.indexWhere((element) => element == id);
    debugPrint(expenses.elementAt(index).name);
    expenses.remove(expenses.elementAt(index));
    documentID.remove(id);
    emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  }

  void updateExpenses(String id) async {
    emit(ExpenseLoading());
    expenseServiceRepository.updateExpenses(docId: id);
    for (int i = 0; i < documentID.length; i++) {
      if (documentID[i] == id) {
        expenses.elementAt(i).name ='netzam';
      }
    }
    emit(ExpenseUpdated(expense: expenses, documentID: documentID));
  }
}
