import 'package:expensetracker/constants/dimen_constants.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:expensetracker/data/enum_extensions/enums_extensions.dart';
import 'package:expensetracker/screens/transactions/expense_tab.dart';
import 'package:expensetracker/screens/transactions/income_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  final TransactionPageTabs initialSelectedTab;
  static const routeName = '/transaction';
  const TransactionPage(
      {Key? key, this.initialSelectedTab = TransactionPageTabs.expense})
      : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentTabIndex;
  late List<TransactionPageTabs> tabs;
  late ScrollController _expenseScrollController, _incomeScrollController;

  @override
  void initState() {
    super.initState();
    tabs = [
      TransactionPageTabs.expense,
      TransactionPageTabs.income,
    ];
    _currentTabIndex = widget.initialSelectedTab.index;
    _tabController = TabController(length: tabs.length, vsync: this);
    _expenseScrollController = ScrollController();
    _incomeScrollController = ScrollController();
  }

  @override
  void didUpdateWidget(TransactionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelectedTab != widget.initialSelectedTab) {
      _currentTabIndex = widget.initialSelectedTab.index;
      _tabController.animateTo(_currentTabIndex);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _expenseScrollController.dispose();
    _incomeScrollController.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentTabIndex == index) {
      if (index == 0) {
        _expenseScrollController.animateTo(
          _expenseScrollController.position.minScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      } else if (index == 1) {
        _incomeScrollController.animateTo(
          _incomeScrollController.position.minScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    }
    _currentTabIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit,ThemeState>(
      builder: (context, state) {
        final _textTheme = state.themeData.textTheme;
        final _colorTheme = state.colorTheme;
        return DefaultTabController(
          initialIndex: _currentTabIndex,
          length: tabs.length,
          child: Column(
            children: [
              TabBar(
                labelColor: _colorTheme.onBackgroundColor,
                unselectedLabelColor: _colorTheme.onBackgroundColor.withOpacity(opacityMed),
                labelStyle: _textTheme.subtitle1,
                controller: _tabController,
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: screenBoundingSpace),
                onTap: _onTabTapped,
                tabs: tabs
                    .map(
                      (tab) => Tab(
                        text: tab.name.toUpperCase(),
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ExpenseTab(
                      scrollController: _expenseScrollController,
                    ),
                    IncomeTab(
                      scrollController: _incomeScrollController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
