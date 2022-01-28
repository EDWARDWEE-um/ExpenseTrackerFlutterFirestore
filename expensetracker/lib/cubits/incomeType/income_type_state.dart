part of 'income_type_cubit.dart';

abstract class IncomeTypeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncomeTypeInitial extends IncomeTypeState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class IncomeTypeLoading extends IncomeTypeInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class IncomeTypeUpdated extends IncomeTypeLoading {
  IncomeTypeUpdated({required this.incomeType, 
  });
  final List<String> incomeType;

  @override
  List<Object?> get props => super.props..addAll([]);
}
