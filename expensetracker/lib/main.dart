import 'package:expensetracker/cubits/commons/auth/auth_cubit.dart';
import 'package:expensetracker/cubits/commons/auth/signed_in_cubit.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenses/expense_cubit.dart';
import 'package:expensetracker/screens/landing_page/landing_page.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit.initial(),
        ),
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
         BlocProvider(
          create: (_) => ExpenseCubit(expenseServiceRepository: ExpenseServiceRepository() ),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Xpense',
                debugShowCheckedModeBanner: false,
                theme: state.themeData,
                home: BlocProvider(
                  lazy: false,
                  create: (_) => SignedInCubit(),
                  child: const LandingPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
