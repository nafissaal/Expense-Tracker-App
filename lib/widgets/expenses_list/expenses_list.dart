import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

// Widget to display a list of expenses
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  // Initializes a list of expenses
  final List<Expense> expenses;
  // Defines a callback function to remove an expense
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // create a scrollable list of expenses
    return ListView.builder(
      // the number of items in the list, which is set to the length of the expenses list
      itemCount: expenses.length,
      // A function that builds each item in the list
      // The function returns a Dismissible widget for swipe-to-delete functionality
      itemBuilder: (ctx, index) => Dismissible(
        // key is a unique key for the widget,
        // which is set to a ValueKey based on the expense object
        key: ValueKey(expenses[index]),
        // background is a widget that is displayed behind the dismissible widget,
        // which is a colored container with a margin
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        // onDismissed is a callback function that is called when the widget is dismissed, 
        // which removes the expense from the list
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        // ExpenseItem to display each expense
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
