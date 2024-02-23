import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fridgespy/models/food.dart';
import 'package:fridgespy/services/food_service.dart';

import '../services/date_service.dart';
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
                bool isExpiringSoon =
                    DateService.isInNext3DaysOrPast(food.expiryDate);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(food.description),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Expiry Date: ${DateService.getFormattedDateString(food.expiryDate)}',
                            ),
                            isExpiringSoon
                                ? Text(
                                    "Expires in ${DateService.getDaysUntilExpiry(food.expiryDate)} days",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const SizedBox.shrink(),
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
