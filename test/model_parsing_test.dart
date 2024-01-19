import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:restauran_app_dicoding/data/model/restaurant.dart';

void main() {
  group('Restaurant Parsing JSON Test', () {
    Map<String, dynamic> inputs = {
      // contains all valid fields - will get parsed
      '{"id": "qwert", "name": "coffe A&B","description": "good", "city": "Sleman","pictureId": "1","rating": 4}':
          const Restaurant(
              id: "qwert",
              name: "coffe A&B",
              description: "good",
              city: "Sleman",
              pictureId: "1",
              rating: 4),

      // contains all valid fields with [name] null and [rating] null   - will get parsed
      '{"id": "qwert", "name": null,"description": "good", "city": "Sleman","pictureId": "1","rating": null}':
          const Restaurant(
              id: "qwert",
              name: "null",
              description: "good",
              city: "Sleman",
              pictureId: "1",
              rating: 0),

      // Wrong [id] data type - will be parsed
      '{"id": "qwert", "name": "coffe A&B","description": "good", "rating": 4}':
          const Restaurant(
              id: "qwert",
              name: "coffe A&B",
              description: "good",
              city: "null",
              pictureId: "null",
              rating: 4),

      // Wrong [id] data type - will not be parsed
      '{"id": 12, "name": "coffe A&B","description": "good","rating": 4}':
          throwsA(isA<TypeError>()),
    };

    inputs.forEach((input, expected) {
      test(
          input,
          () => expect(
              expected is Restaurant
                  ? Restaurant.fromJson(jsonDecode(input))
                  : () => Restaurant.fromJson(jsonDecode(input)),
              expected));
    });
  });
}
