part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props => [status, exceptionError];

  AuthState copyWith({
    FormzStatus? status,
    String? exceptionError,
  }) {
    return AuthState(
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
