import 'package:expensetracker/screens/home/home.dart';
import 'package:expensetracker/screens/portfolio_page/portfolio_page.dart';
import 'package:expensetracker/screens/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter{
  final _allRoutes = <String, Function(RouteSettings settings)>{
    SignInPage.routeName:(_) => const SignInPage(),
    Home.routeName:(_) => const Home(),
    PortfolioPage.routeName:(_) => const PortfolioPage(),
  };
   Route onGenerateRoute(RouteSettings settings) {
    final _builder = _allRoutes[settings.name!];
    final _providers = <BlocProvider>[];

  
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => _providers.isNotEmpty
          ? MultiBlocProvider(
              providers: _providers,
              child: _builder!(settings),
            )
          : _builder!(settings),
    );
  }
}

