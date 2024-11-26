import 'package:flutter/material.dart';
import 'package:expence_tracker/Models/expense.dart';

class ExpenseItems extends StatelessWidget {
  const ExpenseItems(this.expenses, {super.key});

  final Expense expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expenses.title),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  '\$${expenses.amount.toStringAsFixed(2)}',
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenses.category]),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      expenses.date.toString(),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
