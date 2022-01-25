part of 'expense_cubit.dart';

abstract class ExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class ExpenseLoading extends ExpenseInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class ExpenseUpdated extends ExpenseLoading {
  ExpenseUpdated({required this.expense, 
  required this.documentID
  });
  final List<Expense> expense;
  final List documentID;

  @override
  List<Object?> get props => super.props..addAll([]);
}
