import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/db/favorites_db.dart';
import '../../../data/model/restaurant.dart';

part 'favorites_state.dart';
part 'favorites_event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required FavoritesDB favoritesDB})
      : _favoritesDB = favoritesDB,
        super(const FavoritesState()) {
    on<FavoritesFetched>(_onFavoritesFetched);
    on<FavoriteAdded>(_onFavoriteAdded);
    on<FavoriteRemoved>(_onFavoriteRemoved);
  }

  final FavoritesDB _favoritesDB;

  Future<void> _onFavoritesFetched(
      FavoritesFetched event, Emitter<FavoritesState> emit) async {
    try {
      emit(state.copyWith(status: FavoritesStatus.loading));
      final result = await _favoritesDB.getFavorites();

      if (result.isNotEmpty) {
        emit(state.copyWith(
            message: 'Succes Get Favorites : Found Data',
            restaurants: result,
            changeFavoriteStatus: false,
            status: FavoritesStatus.hasData));
      } else {
        emit(state.copyWith(
            message: 'Succes Get Favorites : No Data',
            restaurants: result,
            changeFavoriteStatus: false,
            status: FavoritesStatus.noData));
      }
    } catch (err) {
      emit(state.copyWith(
          message: err.toString(),
          restaurants: [],
          changeFavoriteStatus: false,
          status: FavoritesStatus.error));
    }
  }

  void _onFavoriteAdded(
      FavoriteAdded event, Emitter<FavoritesState> emit) async {
    try {
      emit(state.copyWith(status: FavoritesStatus.loading));
      await _favoritesDB.addFavorite(event.restaurant);
      emit(state.copyWith(changeFavoriteStatus: true));
      await _onFavoritesFetched(FavoritesFetched(), emit);
    } catch (err) {
      emit(state.copyWith(
          message: err.toString(),
          restaurants: [],
          status: FavoritesStatus.error));
    }
  }

  void _onFavoriteRemoved(
      FavoriteRemoved event, Emitter<FavoritesState> emit) async {
    try {
      emit(state.copyWith(status: FavoritesStatus.loading));
      await _favoritesDB.removeFavorite(event.id);
      emit(state.copyWith(changeFavoriteStatus: true));

      await _onFavoritesFetched(FavoritesFetched(), emit);
    } catch (err) {
      emit(state.copyWith(
          message: err.toString(),
          restaurants: [],
          status: FavoritesStatus.error));
    }
  }
}
