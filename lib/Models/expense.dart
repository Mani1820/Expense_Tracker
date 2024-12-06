import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum ExpenseCategory { food, travel, leisure, work }

const categoryIcons = {
  ExpenseCategory.food: Icons.lunch_dining_sharp,
  ExpenseCategory.travel: Icons.flight,
  ExpenseCategory.leisure: Icons.movie_filter,
  ExpenseCategory.work: Icons.work_outline
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.categories, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpense, this.categories)
      : expenses = allExpense
            .where((expense) => expense.category == categories)
            .toList();

  final ExpenseCategory
      categories; // Change this from Category to ExpenseCategory
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
