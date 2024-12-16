import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expence_tracker/Models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final formatter = DateFormat.yMd();
  ExpenseCategory _selectedCategory = ExpenseCategory.food;

  void _enterDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 56, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDialog() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          elevation: 100,
          title: Text(
            'Invalid Input',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            'Enter a valid Title, Amount or Date',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Close'),
            )
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(
            'Invalid Input',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            'Enter a valid Title, Amount or Date',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Close'),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpacing = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constrains) {
      final width = constrains.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpacing + 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            labelText: 'Amount',
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                const SizedBox(height: 10),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: ExpenseCategory.values
                            .map(
                              (categoryIcons) => DropdownMenuItem(
                                value: categoryIcons,
                                child: Text(
                                  categoryIcons.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(
                            () {
                              _selectedCategory = value;
                            },
                          );
                        },
                      ),
                      Spacer(),
                      Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _enterDate,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            labelText: 'Amount',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                            style: TextStyle(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: _enterDate,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (width >= 600)
                  Row(
                    children: [
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: ExpenseCategory.values
                            .map(
                              (categoryIcons) => DropdownMenuItem(
                                value: categoryIcons,
                                child: Text(
                                  categoryIcons.name.toUpperCase(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(
                            () {
                              _selectedCategory = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
