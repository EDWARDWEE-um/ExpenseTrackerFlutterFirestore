part of 'total_expense_cubit.dart';

abstract class TotalExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TotalExpenseInitial extends TotalExpenseState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class TotalExpenseLoading extends TotalExpenseInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class TotalExpenseUpdated extends TotalExpenseLoading {
  TotalExpenseUpdated({ 
  required this.totalExpense,
  });
  final TotalExpense totalExpense;

  @override
  List<Object?> get props => super.props..addAll([]);
}