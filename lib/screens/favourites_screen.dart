import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty)
      return Center(
        child: Text('Favourites Screen'),
      );
    else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            complexity: favouriteMeals[index].complexity,
            duration: favouriteMeals[index].duration,
            affordability: favouriteMeals[index].affordability,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
