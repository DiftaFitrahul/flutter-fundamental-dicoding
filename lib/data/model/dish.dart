class Dish {
  String name;

  Dish({
    required this.name,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        name: json["name"],
      );
}
