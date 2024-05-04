import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/constants.dart';
import 'package:gagu_schedule/domain/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_cubit.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_state.dart';
import 'package:gagu_schedule/presentation/rasp.dart';
import 'package:page_transition/page_transition.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.mainBackroud,
        body: Container(
          padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16),
          child: Column(
            children: [
              listGroup(),
            ],
          ),
        ));
  }

  Widget listGroup() {
    Size size = MediaQuery.of(context).size;

    final internetCheck =
        context.select((InternetCubit cubit) => cubit.state.type);
    final favorites =
        context.select((FavoriteBloc bloc) => bloc.state.favorites);

    return Expanded(
      child: Center(
        child: Builder(
          builder: (_) {
            if (internetCheck == InternetTypes.offline ||
                internetCheck == InternetTypes.unknown) {
              return const Text("Нет соединения");
            }
            if (internetCheck == InternetTypes.connected &&
                favorites.isNotEmpty) {
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorApp.barBackroud,
                      borderRadius: RadiusApp.radiusItem,
                    ),
                    height: 80,
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: size.width,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          favorites[index].name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: ColorApp.textActive,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 36,
                          ),
                          onPressed: () {
                            context.read<FavoriteBloc>().add(
                                DeleteFavoriteEvent(id: favorites[index].id));
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: RaspPage(
                                  name: favorites[index].name,
                                  id: favorites[index].id),
                              type: PageTransitionType.bottomToTop,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text("Нету записей"),
            );
          },
        ),
      ),
    );
  }
}
