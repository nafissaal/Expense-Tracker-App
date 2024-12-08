import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

// this class is to displays a list of expenses and a chart
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // Initializes a list to store the registered expenses
  final List<Expense> _registeredExpenses = [
    // Initial expenses
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.79,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // Opens a modal bottom sheet to add a new expense
  void _openAddExpenseOverlay() {
    // showModalBottomSheet for adding new expenses via NewExpense widget
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // Functions to adds a new expense to the list of registered expenses
  void _addExpense(Expense expense) {
    // Update the state by adding the new expense to the list
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Functions to removes an expense from the list of registered expenses
  void _removeExpense(Expense expense) {
    // Find the index of the expense to be removed
    final expenseIndex = _registeredExpenses.indexOf(expense);

    // Update the state by removing the expense from the list
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Clear any existing snack bars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show a snack bar with an undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          // Functions to undo removal of expenses
          onPressed: () {
            // Update the state by re-adding the expense at its original index
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    final width = MediaQuery.of(context).size.width;

    // Initialize the main content widget
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    // If there are registered expenses, display the ExpensesList widget
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                // Display the chart above the main content on screens with width < 600
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                // // Display the chart beside the main content on screens with width >= 600
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
