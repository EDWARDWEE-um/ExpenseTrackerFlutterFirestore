import 'package:expensetracker/cubits/commons/auth/signed_in_cubit.dart';
import 'package:expensetracker/screens/home_page/home_page.dart';
import 'package:expensetracker/screens/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignedInCubit, SignedInState>(
        builder: (context, state) {
          if (state.isSignedIn) {
            return const HomePage(HomePageArgs(pageIndex: 0));
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}