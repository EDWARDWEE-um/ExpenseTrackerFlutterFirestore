part of 'total_income_cubit.dart';


abstract class TotalIncomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TotalIncomeInitial extends TotalIncomeState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class TotalIncomeLoading extends TotalIncomeInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class TotalIncomeUpdated extends TotalIncomeLoading {
  TotalIncomeUpdated({ 
  required this.totalIncome,
  });
  final TotalIncome totalIncome;

  @override
  List<Object?> get props => super.props..addAll([]);
}