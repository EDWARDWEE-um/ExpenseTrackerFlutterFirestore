import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> performLogin(String provider, List<String> scopes,
      Map<String, String> parameters) async {
    try {
      await FirebaseAuthOAuth().openSignInFlow(provider, scopes, parameters);
    } on PlatformException catch (error) {
      emit(state.copyWith(exceptionError: error.toString()));
    }
  }

  Future signInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        emit(
          state.copyWith(status: FormzStatus.submissionSuccess),
        );
      });
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, exceptionError: e.message));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      return await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, exceptionError: e.message));
    }
  }
}
