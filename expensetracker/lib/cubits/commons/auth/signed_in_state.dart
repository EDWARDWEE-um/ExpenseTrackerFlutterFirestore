part of 'signed_in_cubit.dart';

class SignedInState extends Equatable {
  const SignedInState({required this.isSignedIn});

  final bool isSignedIn;
  @override
  List<Object> get props => [isSignedIn];
}

SignedInState copyWith({required bool isSignedIn}) {
  return SignedInState(isSignedIn: isSignedIn);
}