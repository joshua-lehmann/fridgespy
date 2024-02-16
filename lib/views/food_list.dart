import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fridgespy/models/food.dart';
import 'package:fridgespy/services/food_service.dart';
import 'add_food_form.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Food> _foods = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Stream<QuerySnapshot<Food>> foodStream = FoodService().getFoods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Food>>(
      stream: foodStream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Food>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        _foods = snapshot.data!.docs.map((doc) => doc.data()).toList();
        return Scaffold(
          key: _scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            child: const Icon(Icons.add),
          ),
          endDrawer: const Drawer(
            child: AddFoodForm(),
          ),
          body: ListView.builder(
            itemCount: _foods.length,
            itemBuilder: (context, index) {
              Food food = _foods[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(food.description),
                      if (food.expiryDate != null)
                        Text('Expiry Date: ${food.expiryDate!.day}.${food
                            .expiryDate?.month}.${food.expiryDate?.year}'),
                    ],
                  ),
                ),
              );
            },
          ),
        )
        ,
      },
    );
  }
}