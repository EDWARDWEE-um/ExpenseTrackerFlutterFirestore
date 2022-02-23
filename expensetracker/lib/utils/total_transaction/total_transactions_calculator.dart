import 'package:expensetracker/data/models/expense/expense.dart';
import 'package:expensetracker/data/models/income/income.dart';
import 'package:expensetracker/utils/time_difference/time_difference.dart';

class TotalTransactionsCalculator {
  final List<Expense>? expenses;
  final List<Income>? incomes;

  TotalTransactionsCalculator({
    this.expenses,
    this.incomes,
  });

  double totalTransaction() {
    double total = 0;
    if (expenses != null) {
      for (var expense in expenses!) {
        total += expense.amount;
      }
    }
    if (incomes != null) {
      for (var income in incomes!) {
        total += income.amount;
      }
    }
    return total;
  }

  double totalDailyTransaction() {
    double total = 0;
    if (expenses != null) {
      for (var expense in expenses!) {
        if (TimeDifference(dateTime: expense.dateTime).isToday()) {
          total += expense.amount;
        }
      }
    }
    if (incomes != null) {
      for (var income in incomes!) {
        if (TimeDifference(dateTime: income.dateTime).isToday()) {
          total += income.amount;
        }
      }
    }

    return total;
  }

  double totalWeeklyTransaction() {
    double total = 0;
    if (expenses != null) {
      for (var expense in expenses!) {
        if (TimeDifference(dateTime: expense.dateTime).isThisWeek()) {
          total += expense.amount;
        }
      }
    }
    if (incomes != null) {
      for (var income in incomes!) {
        if (TimeDifference(dateTime: income.dateTime).isThisWeek()) {
          total += income.amount;
        }
      }
    }
    return total;
  }

  double totalMonthlyTransaction() {
    double total = 0;
    if (expenses != null) {
      for (var expense in expenses!) {
        if (TimeDifference(dateTime: expense.dateTime).isThisMonth()) {
          total += expense.amount;
        }
      }
    }
    if (incomes != null) {
      for (var income in incomes!) {
        if (TimeDifference(dateTime: income.dateTime).isThisMonth()) {
          total += income.amount;
        }
      }
    }
    return total;
  }

  double totalYearlyTransaction() {
    double total = 0;
    if (expenses != null) {
      for (var expense in expenses!) {
        if (TimeDifference(dateTime: expense.dateTime).isThisYear()) {
          total += expense.amount;
        }
      }
    }
    if (incomes != null) {
      for (var income in incomes!) {
        if (TimeDifference(dateTime: income.dateTime).isThisYear()) {
          total += income.amount;
          (income.amount.toString());
        }
      }
    }
    return total;
  }
}
