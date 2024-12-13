import 'package:expence_tracker/Models/expense.dart';
import 'package:expence_tracker/expenses_list//expenses_list.dart';
import 'package:expence_tracker/expenses_list/new_expense.dart';
import 'package:expence_tracker/widget/chart/chart.dart';
import 'package:flutter/material.dart';

class Expence extends StatefulWidget {
  const Expence({super.key});

  @override
  State<Expence> createState() => _ExpenceState();
}

class _ExpenceState extends State<Expence> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'title',
        amount: 20,
        date: DateTime.now(),
        category: ExpenseCategory.food)
  ];

  Object? get expense => null;
  void _openAddButton() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: addExpenseData,
        );
      },
    );
  }

  void addExpenseData(Expense expense) {
    setState(
      () {
        _registeredExpense.add(expense);
      },
    );
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpense.insert(expenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Center(
      child: Text('There is no expense start adding'),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: removeExpense,
      );
    }
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
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpense),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpense),
                  ),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
