import 'package:flutter/material.dart';

import '../models/food.dart';
import '../services/date_service.dart';
import '../services/food_service.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    bool isExpiringSoon = DateService.isInNext3DaysOrPast(food.expiryDate);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
                  if (isExpiringSoon)
                    Text(
                      "Expires in ${DateService.getDaysUntilExpiry(food.expiryDate)} days",
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => FoodService().deleteFood(food.id),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
