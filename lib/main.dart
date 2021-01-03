import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS.toList();
  List<Meal> favouriteMeals = [];

  void _toggleFavourite(String mealId) {

    final existingIndex =
        favouriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(() {
      if (existingIndex >= 0) {
        setState(() {
          favouriteMeals.removeAt(existingIndex);
        });
      } else {
        favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });

  }

  bool _isMealFavourite(mealId){

    return favouriteMeals.any((meal) => meal.id==mealId);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffb088f9, color),
        accentColor: MaterialColor(0xffda9ff9, color),
        canvasColor: Color(0xfffcf8ec),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            )),
      ),
      title: 'Fapp',
      routes: {
        '/': (ctx) => TabsScreen(
              favouriteMeals: favouriteMeals,
              toggleFavourite: _toggleFavourite,
            ),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleFav: _toggleFavourite,isFav: _isMealFavourite,),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
