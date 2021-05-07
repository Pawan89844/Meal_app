import 'package:flutter/material.dart';
import '../widgets/meal_items.dart';
import '../model/meals.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouritesMeal;
  FavouritesScreen(this.favouritesMeal);
  @override
  Widget build(BuildContext context) {
    if (favouritesMeal.isEmpty) {
      return Center(
        child: Text('You have no favourites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: favouritesMeal[index].id,
              title: favouritesMeal[index].title,
              imageUrl: favouritesMeal[index].imageUrl,
              duration: favouritesMeal[index].duration,
              complexity: favouritesMeal[index].complexity,
              affordability: favouritesMeal[index].affordability);
        },
        itemCount: favouritesMeal.length,
      );
    }
  }
}
