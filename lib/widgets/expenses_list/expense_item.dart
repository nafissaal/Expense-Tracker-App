import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

// Widget to display individual expense item details
class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  // Initializes an expense object of type Expense
  // The object contains the details of the expense item to be displayed
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Card widget to display expense title, amount, category icon, and date
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // displays the expense amount with two decimal places using the toStringAsFixed method
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // Spacer takes up the available space between the amount and the next row
                const Spacer(),
                Row(
                  children: [
                    // Displays the category icon using the categoryIcons map
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
