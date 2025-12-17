import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expenses/expense_form.dart';
import 'expenses/expenses.dart';
import '../ui/expenses/expense_statistic.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  final List<Expense> _expenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

    void _addExpense(Expense newExpense){
    setState(() {
      _expenses.add(newExpense);
    });
  }

    void _removeExpense(Expense expense){
      final removeIndex = _expenses.indexOf(expense);
      setState(() {
        _expenses.remove(expense);
      });
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Expense deleted"),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo', onPressed: () {
              setState(() {
                _expenses.insert(removeIndex, expense);
              });
            } ),
        )
      );
    }

  void onAddClicked(BuildContext context) {
  
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (c) => Center(
        child: ExpenseForm(onAdd :_addExpense),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => {onAddClicked(context)},
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: Column(
        children: [
          ExpenseStatistic(expenses: _expenses),
          Expanded(child: ExpensesView(expenses : _expenses, onRemoveExpense : _removeExpense),)
          
        ],
      )
      
    );
  }
}
