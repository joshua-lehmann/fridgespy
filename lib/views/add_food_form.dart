import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridgespy/services/barcode_service.dart';

import '../models/food.dart';
import '../provider/food_repo_provider.dart';
import '../services/date_service.dart';
import '../services/food_service.dart';

class AddFoodForm extends ConsumerStatefulWidget {
  const AddFoodForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFoodFormState();
}

class _AddFoodFormState extends ConsumerState<AddFoodForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _barcodeController = TextEditingController();
  final FoodService _foodService = FoodService();
  final barcodeService = BarcodeService();

  String _expiryDate = '';

  @override
  void initState() {
    super.initState();
    _barcodeController.addListener(_onBarcodeChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _barcodeController.removeListener(_onBarcodeChanged);
    super.dispose();
  }

  void _onBarcodeChanged() {
    setState(() {});
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _expiryDate = pickedDate.toIso8601String();
        _expiryDateController.text =
            DateService.getFormattedDateString(pickedDate);
      });
    }
  }

  Future<void> _scanBarcode() async {
    String barcode = await barcodeService.scanBarcode();
    if (barcode.isNotEmpty && barcode != '-1') {
      _barcodeController.text = barcode;
    }
    print('my barcode: $barcode');
  }

  void _submitForm(BuildContext buildContext) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Create a new Food item
      Food newFood = Food(
        name: _nameController.text,
        description: _descriptionController.text,
        expiryDate: DateTime.parse(_expiryDate),
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
    final barcode = _barcodeController.text;
    final foodRepoProduct = barcode.isNotEmpty
        ? ref.watch(foodRepoProductProvider(barcode))
        : const AsyncValue.data(
            null); // Assuming you have a default empty constructor

    if (foodRepoProduct is AsyncData) {
      final value = foodRepoProduct.value;
      if (value != null) {
        _nameController.text = value.displayNameDe;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("FridegSpy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', prefixIcon: Icon(Icons.food_bank)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the food\'s name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description)),
                ),
                TextFormField(
                  controller: _expiryDateController,
                  decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      prefixIcon: Icon(Icons.calendar_month)),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the food\'s expiry date';
                    }
                    return null;
                  },
                  onTap: () => _selectDate(),
                ),
                TextFormField(
                  controller: _barcodeController,
                  decoration: const InputDecoration(
                      labelText: 'Barcode',
                      prefixIcon: Icon(Icons.barcode_reader)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: switch (foodRepoProduct) {
                  AsyncData(:final value) => value != null
                      ? Column(
                          children: [
                            if (value.frontImageUrl != null)
                              Image.network(value.frontImageUrl!),
                          ],
                        )
                      : const Text('No product found'),
                  AsyncError(:final error) =>
                    Text('Error: ${error.toString()}'),
                  _ => const CircularProgressIndicator(),
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => _submitForm(context),
                        child: const Text('Submit'),
                      ),
                      ElevatedButton(
                        onPressed: _scanBarcode,
                        child: const Text('Scan'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
