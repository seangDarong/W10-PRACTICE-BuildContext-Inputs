import 'package:flutter/material.dart';
import '../../models/expense.dart';
import './category_card.dart';

class ExpenseStatistic extends StatelessWidget {
final List<Expense> expenses;


const ExpenseStatistic({required this.expenses, super.key});




@override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Category.values.map((category) {
            return CategoryCard(
              expenses: expenses,
              category: category
              );
          }).toList()
        ),
        ),
    );
  }
}