part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class GetFavoriteEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final Favorite item;

  AddFavoriteEvent({required this.item});
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final int id;

  DeleteFavoriteEvent({required this.id});
}
