import 'package:expensetracker/components/home/current_month_budget.dart';
import 'package:expensetracker/components/home/transactions_today_list.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/home/home_text/home_title.dart';
import '../../components/home/savings_portfolio.dart';
import '../home_page/home_page.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _themeCubit = BlocProvider.of<ThemeCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const HomeTitle(),
                  const SavingsPortfolio(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Budget Allocation',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                              arguments: const HomePageArgs(pageIndex: 3),
                            );
                          },
                          child: const Text('Show Details'),
                        ),
                      ],
                    ),
                  ),
                  const CurrentMonthBudget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                              arguments: const HomePageArgs(pageIndex: 2),
                            );
                          },
                          child: const Text('Show All'),
                        ),
                      ],
                    ),
                  ),
                  const TransactionsTodayList(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Expenses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                              arguments: const HomePageArgs(pageIndex: 2),
                            );
                          },
                          child: const Text('Show All'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Card(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Assets',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                              arguments: const HomePageArgs(pageIndex: 2),
                            );
                          },
                          child: const Text('Show All'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Card(),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _themeCubit.changeTheme(),
                    child: const Text('Show All'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
