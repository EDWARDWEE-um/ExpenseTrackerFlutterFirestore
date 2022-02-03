import 'package:expensetracker/data/models/total_expense/total_expense.dart';
import 'package:expensetracker/data/models/total_income/total_income.dart';

class SwipeCardCondition {
  final int index;
  final TotalExpense? totalExpense;
  final TotalIncome? totalIncome;

  SwipeCardCondition({
    required this.index,
    this.totalExpense,
    this.totalIncome,
  });

  getSwipeCard() {
    switch (index) {
      case 0:
        return (totalExpense != null)
            ? 'Total Daily Expense \n' +
                totalExpense!.totalDailyExpense.toString()
            : 'Total Daily Income \n' +
                totalIncome!.totalDailyIncome.toString();
      case 1:
        return (totalExpense != null)
            ? 'Total Weekly Expense \n' +
                totalExpense!.totalWeeklyExpense.toString()
            : 'Total Weekly Income \n' +
                totalIncome!.totalWeeklyIncome.toString();
      case 2:
        return (totalExpense != null)
            ? 'Total Monthly Expense \n' +
                totalExpense!.totalMonthlyExpense.toString()
            : 'Total Monthly Income \n' +
                totalIncome!.totalMonthlyIncome.toString();
      case 3:
        return (totalExpense != null)
            ? 'Total Yearly Expense \n' +
                totalExpense!.totalYearlyExpense.toString()
            : 'Total Yearly Income \n' +
                totalIncome!.totalYearlyIncome.toString();
      case 4:
        return (totalExpense != null)
            ? 'Total Expense \n' +
                totalExpense!.totalExpense.toString()
            : 'Total Income \n' +
                totalIncome!.totalIncome.toString();
    }
  }
}
