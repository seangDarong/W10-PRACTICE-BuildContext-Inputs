import 'package:flutter/material.dart';
import '../../models/expense.dart';

class CategoryCard extends StatelessWidget {
final List<Expense> expenses;
final Category category;

const CategoryCard({required this.expenses, required this.category, super.key});

double get totalAmount {
  double total = 0;
  for (final expense in expenses) {
    if(expense.category == category){
      total += expense.amount;
    }
  }
  return total;
}

IconData get categoryIcon {
    switch (category) {
      case Category.food:
        return Icons.free_breakfast;
      case Category.travel:
        return Icons.travel_explore;
      case Category.leisure:
        return Icons.holiday_village;
      case Category.work:
        return Icons.work;
    }
  }

@override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text('${totalAmount.toStringAsFixed(2)}\$'),
              const SizedBox(height: 8),
              Icon(categoryIcon),
            ],
          ),
        ),
    );
  }
}