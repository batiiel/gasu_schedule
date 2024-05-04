import 'package:gagu_schedule/internal/dependecies/repository_module.dart';
import 'package:gagu_schedule/domain/bloc/favorite_bloc/favorite_bloc.dart';

class FavoriteModule {
  static FavoriteBloc favoriteBloc() {
    return FavoriteBloc(RepositoryModule.favoriteRepository());
  }
}
