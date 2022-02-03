import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/total_income/total_income.dart';
import 'package:expensetracker/services/repositories/total_income_service_repository.dart';

part 'total_income_state.dart';

class TotalIncomeCubit extends Cubit<TotalIncomeState> {
  final TotalIncomeServiceRepository totalIncomeServiceRepository;
 

  TotalIncomeCubit({required this.totalIncomeServiceRepository})
      : super(TotalIncomeInitial()) {
    getTotalIncome();
  }

  void getTotalIncome() async {
    emit(TotalIncomeLoading());
    DocumentSnapshot incomeList =
        await totalIncomeServiceRepository.getTotalIncome();
    Map<String,dynamic> json = incomeList.data() as Map<String,dynamic>;
    TotalIncome totalIncome = TotalIncome.fromJson(json);
    emit(TotalIncomeUpdated(totalIncome: totalIncome));
  }

  void upsertTotalIncome(TotalIncome totalIncome) async {
    emit(TotalIncomeLoading());
    await totalIncomeServiceRepository.upsertTotalIncome(totalIncome);
    emit(TotalIncomeUpdated(totalIncome: totalIncome));
  }
}