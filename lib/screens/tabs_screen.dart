import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
final Function toggleFavourite;
  TabsScreen({this.favouriteMeals,this.toggleFavourite});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  initState() {
    super.initState();
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavouritesScreen(widget.favouriteMeals),
        'title': 'Your Favourites'
      },
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border), label: 'Favourites'),
        ],
      ),
    );
  }
}
