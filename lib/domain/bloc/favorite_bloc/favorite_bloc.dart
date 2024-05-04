// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:gagu_schedule/domain/model/Favorite.dart';
import 'package:gagu_schedule/domain/repository/favorite_repository.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (evetns, mapper) {
    return droppable<E>().call(evetns.debounce(duration), mapper);
  };
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository _favoriteReposioty;

  FavoriteBloc(this._favoriteReposioty) : super(FavoriteState()) {
    on<GetFavoriteEvent>(_onGetListFavorite);
    on<AddFavoriteEvent>(_onAdd);
    on<DeleteFavoriteEvent>(_onDelete);
  }

  _onGetListFavorite(
      GetFavoriteEvent event, Emitter<FavoriteState> emit) async {
    final List<Favorite> favorites = await _favoriteReposioty.getFavoriteList();
    emit(FavoriteState(favorites: favorites));
  }

  _onAdd(AddFavoriteEvent event, Emitter<FavoriteState> emit) async {
    await _favoriteReposioty.addFavorite(event.item);
    final List<Favorite> favorites = await _favoriteReposioty.getFavoriteList();
    emit(FavoriteState(favorites: favorites));
  }

  _onDelete(DeleteFavoriteEvent event, Emitter<FavoriteState> emit) async {
    _favoriteReposioty.deleteFavorite(event.id);
    final List<Favorite> favorites = await _favoriteReposioty.getFavoriteList();
    emit(FavoriteState(favorites: favorites));
  }
}
