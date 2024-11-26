import 'package:expence_tracker/Models/expense.dart';
import 'package:expence_tracker/expenses_list/expense_items.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseItems(expenses[index]),
    );
  }
}
