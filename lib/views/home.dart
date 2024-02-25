import 'package:flutter/material.dart';

import '../services/food_service.dart';
import 'food_items.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final int _inDays = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("Items Expiring in the next ${_inDays.toString()} days:",
              style: const TextStyle(fontSize: 18)),
        ),
        Expanded(
          child: FoodItems(
            foodStream: FoodService().getFoodExpiringSoon(_inDays),
            searchValue: '',
          ),
        ),
      ],
    );
  }
}
