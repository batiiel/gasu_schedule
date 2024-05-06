import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/constants.dart';
import 'package:gagu_schedule/domain/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_cubit.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_state.dart';
import 'package:gagu_schedule/domain/bloc/teacher_bloc/teacher_bloc.dart';
import 'package:gagu_schedule/domain/model/Favorite.dart';
import 'package:gagu_schedule/presentation/rasp.dart';
import 'package:page_transition/page_transition.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.mainBackroud,
        body: Container(
          padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16),
          child: Column(
            children: [
              search(),
              listGroup(),
            ],
          ),
        ));
  }

  Widget search() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                5.0,
              ),
            ),
          ),
          filled: true,
          fillColor: Colors.white60,
          contentPadding: EdgeInsets.all(15.0),
          hintText: 'Поиск преподователя',
        ),
        onChanged: (value) {
          context.read<TeacherBloc>().add(SearchTeacherEvent(query: value));
        },
      ),
    );
  }

  Widget listGroup() {
    Size size = MediaQuery.of(context).size;

    final internetCheck =
        context.select((InternetCubit cubit) => cubit.state.type);
    final teachers = context.select((TeacherBloc bloc) => bloc.state.teachers);

    return Expanded(
      child: Center(
        child: Builder(
          builder: (_) {
            if (internetCheck == InternetTypes.offline ||
                internetCheck == InternetTypes.unknown) {
              return const Text("Нет соединения");
            }
            if (internetCheck == InternetTypes.connected &&
                teachers.isNotEmpty) {
              return ListView.builder(
                itemCount: teachers.length,
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
                          teachers[index].name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: ColorApp.textActive,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.star_border,
                            size: 36,
                          ),
                          onPressed: () {
                            context.read<FavoriteBloc>().add(AddFavoriteEvent(
                                    item: Favorite(
                                  name: teachers[index].name,
                                  id: teachers[index].id,
                                  type: 'teacher',
                                )));
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: RaspPage(
                                name: teachers[index].name,
                                id: teachers[index].id,
                                type: TypeRasp.teacher,
                              ),
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
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
