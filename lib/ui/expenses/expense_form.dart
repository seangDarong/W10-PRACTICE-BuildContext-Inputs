import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense) onAdd;
  const ExpenseForm({super.key, required this.onAdd});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void pickDate() async{
    final now = DateTime.now();
    final pickedDate = await showDatePicker(context: context, firstDate: now, lastDate: DateTime(now.year + 5));

    if (pickedDate != null){
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
  void onCreate() {
    // 1 - Create the new expense
    String title = _titleController.text;
    String amountInput = _amountController.text;
    double amount = 0;
    DateTime date =  _selectedDate ?? DateTime.now();
    Category category = _selectedCategory;

    if (title.isEmpty){
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invalid Input"),
        content: Text("Title cannot be empty."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
    return;
    }
    double? amounts = double.tryParse(amountInput);
    if (amounts! < 0){
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invalid Input"),
        content: Text("Amount cannot be negative number"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
    return;
    }


    Expense newExpense = Expense(title: title, amount: amounts, date: date, category: _selectedCategory);
  
    // 2  - Forward the new expense to the parent
    widget.onAdd(newExpense);

    // 3- Close the modal
    Navigator.pop(context);
  }

  void onCancel() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(label: Text("Amount")),
            maxLength: 50,
          ),  
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? "No date chosen"
                      : "Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                ),
              ),
              TextButton(
                onPressed: pickDate,
                child: Text("Choose Date"),
              ),

              DropdownButton<Category>(
                value: _selectedCategory,
                onChanged: (Category? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: Category.values.map((Category category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(
                      category.name[0].toUpperCase() + category.name.substring(1), // Capitalize
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          
          ElevatedButton(onPressed: onCancel, child: Text("Cancel"),),
          SizedBox(height: 5,),
          ElevatedButton(onPressed: onCreate, child: Text("Create")),
        ],
      ),
    );
  }
}