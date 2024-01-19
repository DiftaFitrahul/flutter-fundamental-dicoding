import 'package:equatable/equatable.dart';

import './review.dart';
import './category.dart';
import './menu.dart';

class SearchRestaurantResult {
  bool error;
  int founded;
  List<Restaurant> restaurantt;

  SearchRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurantt,
  });

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurantt: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class AllRestaurant {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  AllRestaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory AllRestaurant.fromJson(Map<String, dynamic> json) => AllRestaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"] ?? "null",
        name: json["name"] ?? "null",
        description: json["description"] ?? "null",
        pictureId: json["pictureId"] ?? "null",
        city: json["city"] ?? "null",
        rating: json["rating"]?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pictureId'] = pictureId;
    data['city'] = city;
    data['rating'] = rating;
    return data;
  }

  @override
  List<Object?> get props => [id, name, description, city, pictureId, rating];
}

class DetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  bool isFavorite;
  List<Category> categories;
  Menu menu;
  double rating;
  List<CustomerReview> customerReviews;

  DetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menu,
    required this.rating,
    required this.customerReviews,
    this.isFavorite = false,
  });

  static final empty = DetailRestaurant(
      id: '',
      name: '',
      description: '',
      city: '',
      address: '',
      pictureId: '',
      categories: [],
      menu: Menu(foods: [], drinks: []),
      rating: 0,
      customerReviews: []);

  DetailRestaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? city,
    String? address,
    String? pictureId,
    List<Category>? categories,
    Menu? menu,
    double? rating,
    bool? isFavorite,
    List<CustomerReview>? customerReviews,
  }) {
    return DetailRestaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        city: city ?? this.city,
        address: address ?? this.address,
        pictureId: pictureId ?? this.pictureId,
        categories: categories ?? this.categories,
        menu: menu ?? this.menu,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
        customerReviews: customerReviews ?? this.customerReviews);
  }

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        id: json["id"],
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        city: json["city"] ?? '',
        address: json["address"] ?? '',
        pictureId: json["pictureId"] ?? '',
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menu: Menu.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}
