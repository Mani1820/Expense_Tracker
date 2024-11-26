import 'package:expence_tracker/Models/expense.dart';
import 'package:expence_tracker/expenses_list//expenses_list.dart';
import 'package:expence_tracker/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expence extends StatefulWidget {
  const Expence({super.key});

  @override
  State<Expence> createState() => _ExpenceState();
}

class _ExpenceState extends State<Expence> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'Amaran',
        amount: 190.00,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'outing',
        amount: 23.30,
        date: DateTime.now(),
        category: Category.travel)
  ];
  void _openAddButton() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpense();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              _openAddButton();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpense),
          )
        ],
      ),
    );
  }
}
