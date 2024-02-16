import 'package:flutter/foundation.dart';
import 'package:fridgespy/models/food.dart';
import 'package:fridgespy/services/firebase_service.dart';
import 'package:fridgespy/services/food_service.dart';

class FoodViewModel extends ChangeNotifier {
  final FoodService _foodService = FoodService();
  List<Food> foods = [];

  FoodViewModel() {
    getFoods();
  }

  Future<void> getFoods() async {
    foods = await _foodService.getFoods();
    notifyListeners();
  }

}
