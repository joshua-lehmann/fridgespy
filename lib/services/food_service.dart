import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridgespy/models/food.dart';
import 'package:fridgespy/services/firebase_service.dart';

class FoodService {
  final CollectionReference _foodCollection =
  FirebaseService().firestore.collection("foods");

  Future<List<Food>> getFoods() async {
    var snapshots = await _foodCollection.get();
    return snapshots.docs
        .map((doc) => doc.data())
        .where((data) => data != null)
        .map((data) => Food.fromFirestore(data as Map<String, dynamic>))
        .toList();
  }

  Future<void> addFood(Food food) async {
    await _foodCollection.add(food.toFirestore());
  }

}
