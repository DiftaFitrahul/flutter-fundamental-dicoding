import './dish.dart';

class Menu {
  List<Dish> foods;
  List<Dish> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: List<Dish>.from(json["foods"].map((x) => Dish.fromJson(x))),
      drinks: List<Dish>.from(json["drinks"].map((x) => Dish.fromJson(x))),
    );
  }
}
