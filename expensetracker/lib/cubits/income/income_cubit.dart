import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:expensetracker/services/repositories/income_service_repository.dart';
part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  final IncomeServiceRepository incomeServiceRepository;
  final List<Income> incomes = [];
  final List documentID = [];

  IncomeCubit({required this.incomeServiceRepository})
      : super(IncomeInitial()) {
    getIncomes();
  }

  void getIncomes() async {
    emit(IncomeLoading());
    QuerySnapshot incomeList = await incomeServiceRepository.getIncome();
    for (int i = 0; i < incomeList.docs.length; i++) {
      Map<String, dynamic> incomeMap =
          incomeList.docs[i].data() as Map<String, dynamic>;
      if (!documentID.contains(incomeList.docs[i].id)) {
        incomes.add(Income.fromJson(incomeMap));
        documentID.add(incomeList.docs[i].id);
      }
    }
    emit(IncomeUpdated(income: incomes, documentID: documentID));
  }

  void addIncomes(Income income) async {
    emit(IncomeLoading());
    String docID = await incomeServiceRepository.addNewIncome(income);
    incomes.add(income);
    documentID.add(docID);
    emit(IncomeUpdated(income: incomes, documentID: documentID));
  }

  void deleteIncomes(String id) async {
    emit(IncomeLoading());
    incomeServiceRepository.deleteIncome(docId: id);
    for (int i = 0; i < documentID.length; i++) {
      if (documentID[i] == id) {
        incomes.removeAt(i);
        documentID.remove(id);
      }
    }
    emit(IncomeUpdated(income: incomes, documentID: documentID));
  }

  void updateIncome(String id) async {
    emit(IncomeLoading());
    incomeServiceRepository.updateIncome(docId: id);
    for (int i = 0; i < documentID.length; i++) {
      if (documentID[i] == id) {
        incomes.elementAt(i).name ='netzam';
      }
    }
    emit(IncomeUpdated(income: incomes, documentID: documentID));
  }
}
