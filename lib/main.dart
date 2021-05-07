import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'model/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
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

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouritesMeal = [];

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouritesMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouritesMeal.removeAt(existingIndex);
      });
    } else {
      _favouritesMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavourites(String id) {
    return _favouritesMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: GoogleFonts.itim().toString(),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.notoSans().toString(),
                  fontWeight: FontWeight.bold),
            ),
      ),
      /* home: CategoryScreen(), */
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favouritesMeal),
        CategoryMealsScreen.routName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routName: (ctx) =>
            MealDetailsScreen(_toggleFavourite, _isMealFavourites),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
    );
  }
}
