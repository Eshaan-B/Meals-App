import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle, categoryId;
  List<Meal> displayedMeals;

  @override
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    categoryTitle = routeArgs['title'];
    categoryId = routeArgs['id'];
    displayedMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: (displayedMeals.length!=0)?ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              removeMeal: _removeMeal,
            );
          },
          itemCount: displayedMeals.length,
        ):Center(child: Text('No meals available!'),));
  }
}
