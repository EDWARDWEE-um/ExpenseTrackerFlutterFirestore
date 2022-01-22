import 'package:expensetracker/cubits/commons/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';



Widget SignInWithGoogle() {
  return BlocBuilder<AuthCubit, AuthState>(
    buildWhen: (previous, current) => previous.status != current.status,
    builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SignInButton(Buttons.Google,
              onPressed: () => context.read<AuthCubit>().signInWithGoogle()));
    },
  );
}

