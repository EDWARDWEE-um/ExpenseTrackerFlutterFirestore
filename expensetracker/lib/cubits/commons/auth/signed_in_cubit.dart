import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signed_in_state.dart';

class SignedInCubit extends Cubit<SignedInState> {
  SignedInCubit() : super(const SignedInState(isSignedIn: false)) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        emit(copyWith(isSignedIn: false));
      } else {
        emit(copyWith(isSignedIn: true));
      }
    });
  }
}