import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/food.dart';
import 'food_card.dart';

class FoodItems extends StatelessWidget {
  const FoodItems({
    Key? key,
    required this.foodStream,
    required this.searchValue,
  }) : super(key: key);

  final Stream<QuerySnapshot<Food>> foodStream;
  final String searchValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Food>>(
      stream: foodStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const Text('No data found');
        }

        final foodList = snapshot.data!.docs.map((e) => e.data()).toList();
        final searchedList = searchValue.isNotEmpty
            ? foodList
                .where((food) =>
                    food.name.toLowerCase().contains(searchValue.toLowerCase()))
                .toList()
            : foodList;

        return ListView.builder(
          itemCount: searchedList.length,
          itemBuilder: (context, index) {
            Food food = searchedList[index];
            return FoodCard(
              food: food,
            );
          },
        );
      },
    );
  }
}
