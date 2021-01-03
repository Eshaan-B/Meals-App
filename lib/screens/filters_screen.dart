import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen({this.saveFilters, this.currentFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState(){  
    super.initState();
    _glutenFree=widget.currentFilters['gluten'];
    _vegan=widget.currentFilters['vegan'];
    _vegetarian=widget.currentFilters['vegetarian'];
    _lactoseFree=widget.currentFilters['lactose'];
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function updateValue) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          _buildSwitchListTile(
              'Gluten Free', 'Show only gluten-free meals', _glutenFree,
              (newValue) {
            setState(() {
              _glutenFree = newValue;
            });
          }),
          _buildSwitchListTile(
              'Vegetarian', 'Show only vegetarian meals', _vegetarian,
              (newValue) {
            setState(() {
              _vegetarian = newValue;
            });
          }),
          _buildSwitchListTile('Vegan', 'Show only vegan meals', _vegan,
              (newValue) {
            setState(() {
              _vegan = newValue;
            });
          }),
          _buildSwitchListTile(
              'Lactose Free', 'Show only lactose-free meals', _lactoseFree,
              (newValue) {
            setState(() {
              _lactoseFree = newValue;
            });
          }),
        ],
      ),
    );
  }
}
