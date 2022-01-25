import 'package:expensetracker/components/commons/sign_in_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../cubits/commons/auth/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/signIn';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: BlocProvider(
        create: (_) => AuthCubit(),
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  var snackBar = SnackBar(
                    content: Text(state.exceptionError),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state.status.isSubmissionSuccess) {
                  var snackBar = const SnackBar(
                    content: Text("Success!"),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) => Stack(
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.fromLTRB(38.0, 0, 38.0, 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 100,),
                              Column(
                                children: [
                                  signInWithGoogle(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      state.status.isSubmissionInProgress
                          ? const Positioned(
                              child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container(),
                    ],
                  )),
        ),
      ),
    );
  }
}
