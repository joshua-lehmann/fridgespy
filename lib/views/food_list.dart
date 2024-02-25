import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridgespy/provider/search_provider.dart';
import 'package:fridgespy/services/food_service.dart';
import 'package:fridgespy/views/food_items.dart';

import 'add_food_form.dart';

class FoodList extends ConsumerStatefulWidget {
  const FoodList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FoodListState();
}

class _FoodListState extends ConsumerState<FoodList> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref.read(searchProvider.notifier).search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchValue = ref.watch(searchProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddFoodForm(null)),
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FoodItems(
              foodStream: FoodService().getFoodsOrderByExpiryDate(),
              searchValue: searchValue,
            ),
          ),
        ],
      ),
    );
  }
}
