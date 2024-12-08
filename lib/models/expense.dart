import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Define a formatter for dates
final formatter = DateFormat.yMd();

// Create a uuid instance
const uuid = Uuid();

// Defines an enum for expense categories
enum Category { food, travel, leisure, work }

// Defines a map to maps each category to an icon from the Icons class
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// Defines the Expense model, this class represents a single expense
class Expense {
  // Constructor for Expense 
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  // Unique id for the expense, generated using the Uuid package
  final String id;
  // Title of the expense
  final String title;
  // Amount of the expense
  final double amount;
  // Date of the expense
  final DateTime date;
  // Category of the expense
  final Category category;

  // Getter to returns a formatted date string using the DateFormat.yMd() formatter
  String get formattedDate {
    return formatter.format(date);
  }
}

// Defines the ExpenseBucket model, this class represents a collection of expenses grouped by category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // Factory method to create an ExpenseBucket for a specific category
  // This method takes a list of Expense objects and a category as parameters,
  // and returns an ExpenseBucket instance with the filtered expenses
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  // Category of the expense bucket
  final Category category;
  // List of Expense objects in the bucket
  final List<Expense> expenses;

  // Calculates the total expenses in the bucket
  double get totalExpenses {
    double sum = 0;

    // Iterate over each expense in the bucket and add to the sum
    for (final expense in expenses) {
      sum += expense.amount; //sum = sum + expense.amount
    }

    return sum;
  }
}
