import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/services/repositories/income_type_service_repository.dart';
part 'income_type_state.dart';

class IncomeTypeCubit extends Cubit<IncomeTypeState> {
  final IncomeTypeServiceRepository incomeTypeServiceRepository;
  final List<String> incomeType = [];

  IncomeTypeCubit({required this.incomeTypeServiceRepository})
      : super(IncomeTypeInitial()) {
    getIncomeType();
  }

  void getIncomeType() async {
    emit(IncomeTypeLoading());
    QuerySnapshot incomeTypeList =
        await incomeTypeServiceRepository.getIncomeType();
    for (int i = 0; i < incomeTypeList.docs.length; i++) {
      if (!incomeType.contains(incomeTypeList.docs[i].id)) {
        incomeType.add(incomeTypeList.docs[i].id);
      }
    }
    emit(
      IncomeTypeUpdated(
        incomeType: incomeType,
      ),
    );
  }
}
