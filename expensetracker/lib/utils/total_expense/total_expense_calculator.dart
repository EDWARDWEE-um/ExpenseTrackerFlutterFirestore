import 'package:expensetracker/data/models/expense.dart';
import 'package:expensetracker/utils/time_difference/time_difference.dart';
import 'package:flutter/material.dart';

class TotalExpenseCalculator {
  final List<Expense> expenses;

  TotalExpenseCalculator({
    required this.expenses,
  });

  double totalExpense() {
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    debugPrint(total.toString());
    return total;
  }

  double totalDailyExpense() {
    double total = 0;
    for (var expense in expenses) {
      if (TimeDifference(dateTime: expense.dateTime).isToday()) {
        total += expense.amount;
      }
    }
    debugPrint(TimeDifference(dateTime: DateTime(2022, 2, 15))
        .isThisMonth()
        .toString());
    debugPrint(total.toString());
    return total;
  }

  double totalWeeklyExpense() {
    double total = 0;
    for (var expense in expenses) {
      if (TimeDifference(dateTime: expense.dateTime).isThisWeek()) {
        total += expense.amount;
      }
    }
    return total;
  }

   double totalMonthlyExpense() {
    double total = 0;
    for (var expense in expenses) {
      if (TimeDifference(dateTime: expense.dateTime).isThisMonth()) {
        total += expense.amount;
      }
    }
    return total;
  }

   double totalYearlyExpense() {
    double total = 0;
    for (var expense in expenses) {
      if (TimeDifference(dateTime: expense.dateTime).isThisYear()) {
        total += expense.amount;
      }
    }
    return total;
  }
}
