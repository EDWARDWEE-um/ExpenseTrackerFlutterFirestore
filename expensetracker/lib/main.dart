import 'package:expensetracker/cubits/commons/auth/auth_cubit.dart';
import 'package:expensetracker/cubits/commons/auth/signed_in_cubit.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/cubits/expenseType/expense_type_cubit.dart';
import 'package:expensetracker/cubits/expense/expense_cubit.dart';
import 'package:expensetracker/cubits/income/income_cubit.dart';
import 'package:expensetracker/cubits/incomeType/income_type_cubit.dart';
import 'package:expensetracker/cubits/totalTransactions/expense/total_expense_cubit.dart';
import 'package:expensetracker/cubits/totalTransactions/income/total_income_cubit.dart';
import 'package:expensetracker/screens/landing_page/landing_page.dart';
import 'package:expensetracker/service_locator.dart';
import 'package:expensetracker/services/navigation_service.dart';
import 'package:expensetracker/services/repositories/expense_service_repository.dart';
import 'package:expensetracker/services/repositories/expense_type_service_repository.dart';
import 'package:expensetracker/services/repositories/income_service_repository.dart';
import 'package:expensetracker/services/repositories/income_type_service_repository.dart';
import 'package:expensetracker/services/repositories/total_expense_service_repository.dart';
import 'package:expensetracker/services/repositories/total_income_service_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _sharedPrefs = await SharedPreferences.getInstance();
  void setupLocator() {
    sl.registerLazySingleton<SharedPreferences>(() => _sharedPrefs);
  }

  setupLocator();
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
  late AppRouter _appRouter;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _preferences = value;
      });
    });
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    String sharedPrefsTheme = _preferences.getString('themeKey').toString();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit.initial(type: sharedPrefsTheme),
        ),
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
        BlocProvider(
          create: (_) => ExpenseCubit(
              expenseServiceRepository: ExpenseServiceRepository()),
        ),
        BlocProvider(
          create: (_) => IncomeCubit(
            incomeServiceRepository: IncomeServiceRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ExpenseTypeCubit(
            expenseTypeServiceRepository: ExpenseTypeServiceRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => IncomeTypeCubit(
            incomeTypeServiceRepository: IncomeTypeServiceRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => TotalExpenseCubit(
            totalExpenseServiceRepository: TotalExpenseServiceRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => TotalIncomeCubit(
            totalIncomeServiceRepository: TotalIncomeServiceRepository(),
          ),
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
                onGenerateRoute: _appRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
