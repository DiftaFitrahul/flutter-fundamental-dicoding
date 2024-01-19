import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../model/restaurant.dart';
import '../model/review.dart';

class RestaurantAPIService {
  final _baseUrl = 'https://restaurant-api.dicoding.dev';
  final Client client;

  RestaurantAPIService(this.client);

  Future<AllRestaurant> getListRestauran() async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/list'));
      if (response.statusCode == 200) {
        return AllRestaurant.fromJson(jsonDecode(response.body));
      } else {
        throw ('error occured');
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<SearchRestaurantResult> searchRestaurant(
      {required String query}) async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/search?q=$query'));
      if (response.statusCode == 200) {
        return SearchRestaurantResult.fromJson(jsonDecode(response.body));
      } else {
        throw ('error occured');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<DetailRestaurant> getDetailRestaurant({required String id}) async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/detail/$id'));
      if (response.statusCode == 200) {
        return DetailRestaurant.fromJson(
            jsonDecode((response.body))['restaurant']);
      } else {
        throw ('error occured');
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CustomerReview>> postRestaurantReview(
      {required UserReview review}) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/review'),
        body: review.toJson(),
      );
      if (response.statusCode == 201) {
        final listCustomerReviews =
            (jsonDecode(response.body))['customerReviews'] as List;
        return listCustomerReviews
            .map((review) => CustomerReview.fromJson(review))
            .toList();
      } else {
        throw ('error occured');
      }
    } catch (_) {
      rethrow;
    }
  }
}
