import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/bloc/restaurant/restaurant.dart';

class HomeIosSearchBar extends StatelessWidget {
  const HomeIosSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: (query) {
        context.read<RestaurantBloc>().add(RestaurantSearched(query: query));
      },
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
    );
  }
}
