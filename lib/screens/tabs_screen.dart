import 'package:flutter/material.dart';
import '../model/meals.dart';
import '../screens/catergory_screen.dart';
import '../screens/favourites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouritesMeal;

  TabsScreen(this.favouritesMeal);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<Object, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoryScreen(), 'title': 'Categories'},
      {
        'page': FavouritesScreen(
          widget.favouritesMeal,
        ),
        'title': 'Favourites'
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Daily Meal'.toUpperCase(),
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.pink,
          currentIndex: _selectedPageIndex,
          elevation: 5,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
          ]),
    );
  }
}
