import 'package:expensetracker/data/models/total_expense.dart';

class SwipeCardCondition{
  final int index;
  final TotalExpense totalExpense;

  SwipeCardCondition({required this.index, required this.totalExpense});

  getSwipeCard(){
    switch (index) {
      case 0:
        return 'Total Daily Expense \n'+totalExpense.totalDailyExpense.toString(); 
      case 1:
        return 'Total Weekly Expense \n'+totalExpense.totalWeeklyExpense.toString();
      case 2:
        return 'Total Monthly Expense \n'+totalExpense.totalMonthlyExpense.toString();
      case 3:
        return 'Total Yearly Expense \n'+totalExpense.totalYearlyExpense.toString();
      case 4:
        return 'Total Expense \n'+totalExpense.totalExpense.toString();
    }
  }
}