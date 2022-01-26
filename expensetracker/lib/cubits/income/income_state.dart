
part of 'income_cubit.dart';

abstract class IncomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncomeInitial extends IncomeState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class IncomeLoading extends IncomeInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class IncomeUpdated extends IncomeLoading {
  IncomeUpdated({required this.income, 
  required this.documentID
  });
  final List<Income> income;
  final List documentID;

  @override
  List<Object?> get props => super.props..addAll([]);
}
