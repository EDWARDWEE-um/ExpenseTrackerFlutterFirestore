part of 'expense_type_cubit.dart';

abstract class ExpenseTypeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpenseTypeInitial extends ExpenseTypeState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class ExpenseTypeLoading extends ExpenseTypeInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class ExpenseTypeUpdated extends ExpenseTypeLoading {
  ExpenseTypeUpdated({required this.expenseType, 
  });
  final List<String> expenseType;

  @override
  List<Object?> get props => super.props..addAll([]);
}
