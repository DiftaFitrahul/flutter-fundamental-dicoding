import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/bloc/restaurant/restaurant.dart';

class HomeAndroidSearchBar extends StatelessWidget {
  const HomeAndroidSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search',
      leading: const Icon(Icons.search),
      elevation: MaterialStateProperty.all(0),
      hintStyle: MaterialStateProperty.all(
        TextStyle(
          color: Colors.grey.withOpacity(0.8),
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: MaterialStateColor.resolveWith(
          (states) => Colors.grey.withOpacity(0.1)),
      onChanged: (query) {
        context.read<RestaurantBloc>().add(RestaurantSearched(query: query));
      },
    );
  }
}
