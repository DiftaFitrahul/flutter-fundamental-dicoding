import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:restauran_app_dicoding/data/model/restaurant.dart';
import 'package:restauran_app_dicoding/data/model/review.dart';
import 'package:restauran_app_dicoding/data/repository/restaurant_api_service.dart';

import 'restaurant_api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const baseUrl = 'https://restaurant-api.dicoding.dev';

  group("Fetch Restaurant API test", () {
    late MockClient mockClient;
    late RestaurantAPIService restaurantAPIService;

    setUp(() {
      mockClient = MockClient();
      restaurantAPIService = RestaurantAPIService(mockClient);
    });

    // Get all restaurant - will return AllRestaurant Data
    test("Fetch All Restaurant test", () async {
      final uri = Uri.parse('$baseUrl/list');
      const jsonMap = {
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
        ]
      };

      // return list restaurant when http response is successfull
      // arrange
      when(mockClient.get(uri))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonMap), 200));

      // act
      final result = await restaurantAPIService.getListRestauran();

      // assert
      expect(result, isA<AllRestaurant>());
      verify(mockClient.get(uri));
    });

    // Get restaurant based on search [name] - will return SearchRestaurantResult Data
    test('Fetch Search Restaurant Test', () async {
      final uri = Uri.parse('$baseUrl/search?q=Kafe Kita');
      const jsonMap = {
        "error": false,
        "founded": 1,
        "restaurants": [
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description":
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };

      // arrange
      when(mockClient.get(uri))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonMap), 200));

      // act
      final result =
          await restaurantAPIService.searchRestaurant(query: 'Kafe Kita');

      // assert
      expect(result, isA<SearchRestaurantResult>());
      verify(mockClient.get(uri));
    });

    // Get detail restaurant based on [Restaurant Id] - will return DetailRestaurant Data
    test('Get Detail Restaurant Test', () async {
      final uri = Uri.parse('$baseUrl/detail/rqdv5juczeskfw1e867');
      const jsonMap = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
            {"name": "Italia"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Paket rosemary"},
              {"name": "Toastie salmon"},
              {"name": "Bebek crepes"},
              {"name": "Salad lengkeng"}
            ],
            "drinks": [
              {"name": "Es krim"},
              {"name": "Sirup"},
              {"name": "Jus apel"},
              {"name": "Jus jeruk"},
              {"name": "Coklat panas"},
              {"name": "Air"},
              {"name": "Es kopi"},
              {"name": "Jus alpukat"},
              {"name": "Jus mangga"},
              {"name": "Teh manis"},
              {"name": "Kopi espresso"},
              {"name": "Minuman soda"},
              {"name": "Jus tomat"}
            ]
          },
          "rating": 4.2,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            },
            {
              "name": "Luffy",
              "review": "Daginganya enakk",
              "date": "17 Januari 2024"
            },
            {"name": "halo", "review": "123", "date": "17 Januari 2024"}
          ]
        }
      };

      // arrange
      when(mockClient.get(uri))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonMap), 200));

      // act
      final result = await restaurantAPIService.getDetailRestaurant(
          id: "rqdv5juczeskfw1e867");

      // assert
      expect(result, isA<DetailRestaurant>());
      verify(mockClient.get(uri));
    });

    // Post user review on certain restaurant based on [Restaurant Id] - will return List<CustomerReview> Data
    test('Post Restaurant Review Test', () async {
      final uri = Uri.parse('$baseUrl/review');
      const jsonMap = {
        "error": false,
        "message": "success",
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          },
          {
            "name": "Luffy",
            "review": "Daginganya enakk",
            "date": "17 Januari 2024"
          }
        ]
      };

      final userReview = UserReview(
          id: "rqdv5juczeskfw1e867", name: "Luffy", review: "Daginganya enakk");

      // arrange
      when(mockClient.post(uri, body: userReview.toJson()))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonMap), 201));

      // act
      final result =
          await restaurantAPIService.postRestaurantReview(review: userReview);

      // assert
      expect(result, isA<List<CustomerReview>>());
      verify(mockClient.post(uri, body: userReview.toJson()));
    });
  });
}
