import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fridgespy/models/food.dart';
import 'package:fridgespy/services/food_service.dart';

import 'add_food_form.dart';

class FoodList extends StatelessWidget {
  FoodList({super.key});

  final _foodService = FoodService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFoodForm()),
          ),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot<Food>>(
          stream: _foodService.getFoodsOrderByExpiryDate(),
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
            List foodList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                Food food = foodList[index].data();
                print("$index + ${food.name}");
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(food.description),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Expiry Date: ${food.expiryDate!.day}.${food.expiryDate?.month}.${food.expiryDate?.year}'),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _foodService.deleteFood(food.id),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
