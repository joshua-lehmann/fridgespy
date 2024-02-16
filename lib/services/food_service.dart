import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridgespy/models/food.dart';
import 'package:fridgespy/services/firebase_service.dart';

class FoodService {
  final CollectionReference<Food> _foodCollection = FirebaseService()
      .firestore
      .collection("foods")
      .withConverter<Food>(
          fromFirestore: Food.fromFirestore,
          toFirestore: (food, _) => food.toFirestore());

  Stream<QuerySnapshot<Food>> getFoods() {
     return _foodCollection.snapshots();
  }

  Future<void> addFood(Food food) async {
    await _foodCollection.add(food);
  }
}
