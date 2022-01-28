import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/services/repositories/expense_type_service_repository.dart';
part 'expense_type_state.dart';

class ExpenseTypeCubit extends Cubit<ExpenseTypeState> {
  final ExpenseTypeServiceRepository expenseTypeServiceRepository;
  final List<String> expenseType = [];

  ExpenseTypeCubit({required this.expenseTypeServiceRepository})
      : super(ExpenseTypeInitial()) {
    getExpenseType();
  }

  void getExpenseType() async {
    emit(ExpenseTypeLoading());
    QuerySnapshot expenseTypeList = await expenseTypeServiceRepository.getExpenseType();
    for (int i = 0; i < expenseTypeList.docs.length; i++) {
      if (!expenseType.contains(expenseTypeList.docs[i].id)) {
        expenseType.add(expenseTypeList.docs[i].id);
      }
    }
    emit(ExpenseTypeUpdated(expenseType: expenseType,),);
  }
}

//   void addExpenses(Expense expense) async {
//     emit(ExpenseLoading());
//     String docID = await expenseServiceRepository.addNewExpense(expense);
//     expenses.add(expense);
//     documentID.add(docID);
//     emit(ExpenseUpdated(expense: expenses, documentID: documentID));
//   }

//   void deleteExpenses(String id) async {
//     emit(ExpenseLoading());
//     expenseServiceRepository.deleteExpenses(docId: id);
//     for (int i = 0; i < documentID.length; i++) {
//       if (documentID[i] == id) {
//         expenses.removeAt(i);
//         documentID.remove(id);
//       }
//     }
//     emit(ExpenseUpdated(expense: expenses, documentID: documentID));
//   }

//   void updateExpenses(String id) async {
//     emit(ExpenseLoading());
//     expenseServiceRepository.updateExpenses(docId: id);
//     for (int i = 0; i < documentID.length; i++) {
//       if (documentID[i] == id) {
//         expenses.elementAt(i).name ='netzam';
//       }
//     }
//     emit(ExpenseUpdated(expense: expenses, documentID: documentID));
//   }
// }
