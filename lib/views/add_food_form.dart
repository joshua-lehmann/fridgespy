import 'package:flutter/material.dart';
import 'package:fridgespy/services/food_service.dart';

import '../models/food.dart';

class AddFoodForm extends StatefulWidget {
  const AddFoodForm({super.key});

  @override
  _AddFoodFormState createState() => _AddFoodFormState();
}

class _AddFoodFormState extends State<AddFoodForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final FoodService _foodService = FoodService();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _expiryDateController.text = pickedDate.toIso8601String();
      });
    }
  }

  void _submitForm(BuildContext buildContext) async {
    if (_formKey.currentState!.validate()) {
      // Create a new Food item
      Food newFood = Food(
        name: _nameController.text,
        description: _descriptionController.text,
        expiryDate: _expiryDateController.text.isNotEmpty
            ? DateTime.parse(_expiryDateController.text)
            : null,
      );

      await _foodService.addFood(newFood);

      // Clear the form
      _formKey.currentState!.reset();

      const snackBar = SnackBar(
        content: Text('Food added successfully!'),
      );
      if (!buildContext.mounted) {
        return;
      }
      ScaffoldMessenger.of(buildContext).showSnackBar(snackBar);
      Navigator.pop(buildContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("FridegSpy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the food\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
                onTap: () => _selectDate(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
