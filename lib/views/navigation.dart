import 'package:flutter/material.dart';

import 'food_list.dart';
import 'home.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Food List',
            ),
          ],
        ),
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("FridegSpy"),
        ),
        body: <Widget>[
          const Home(),
          FoodList(),
        ][currentPageIndex]);
  }
}
