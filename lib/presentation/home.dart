// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gagu_schedule/constants.dart';
import 'package:gagu_schedule/domain/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_cubit.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_state.dart';
import 'package:gagu_schedule/domain/bloc/teacher_bloc/teacher_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/favorite_module.dart';
import 'package:gagu_schedule/internal/dependecies/group_module.dart';
import 'package:gagu_schedule/domain/bloc/group_bloc/group_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/teacher_module.dart';
import 'package:gagu_schedule/presentation/favorite_page.dart';

import 'package:gagu_schedule/presentation/group_page.dart';
import 'package:gagu_schedule/presentation/teacher_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', 'RU')],
      locale: const Locale('ru'),
      title: 'Rasp GASU',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Расписание ГАГУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;

  List<Widget> pages = const [
    FavoritePage(),
    GroupPage(),
    TeacherPage(),
  ];

  List<IconData> iconList = [
    Icons.star,
    Icons.group,
    Icons.person,
  ];

  List<String> titleList = [
    "Избранное",
    "Группы",
    "Преподователи",
  ];

  @override
  Widget build(BuildContext context) {
    final GroupBloc _groupBloc = GroupModule.groupBloc();
    final TeacherBloc _teacherBloc = TeacherModule.teacherBloc();
    final Connectivity connectivity = Connectivity();
    final FavoriteBloc _favoriteBloc = FavoriteModule.favoriteBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: connectivity)),
        BlocProvider<GroupBloc>(create: (context) => _groupBloc),
        BlocProvider<TeacherBloc>(create: (context) => _teacherBloc),
        BlocProvider<FavoriteBloc>(create: (context) => _favoriteBloc),
      ],
      child: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          context.read<GroupBloc>().add(GetGroupsEvent());
          context.read<TeacherBloc>().add(GetTeacherEvent());
          context.read<FavoriteBloc>().add(GetFavoriteEvent());
        },
        child: Scaffold(
          backgroundColor: ColorApp.mainBackroud,
          appBar: AppBar(
            backgroundColor: ColorApp.barBackroud,
            title: Center(
              child: Text(
                titleList[_bottomNavIndex],
                style: const TextStyle(
                    color: ColorApp.textActive,
                    fontWeight: FontWeight.w600,
                    fontSize: 28),
              ),
            ),
            elevation: 0.0,
          ),
          body: IndexedStack(
            index: _bottomNavIndex,
            children: pages,
          ),
          bottomNavigationBar: AnimatedBottomNavigationBar(
            // splashColor: Colors.black,
            backgroundColor: ColorApp.barBackroud,
            inactiveColor: ColorApp.textInActive,
            activeColor: ColorApp.active,
            icons: iconList,
            iconSize: 32,
            height: 70,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.none,
            onTap: (index) {
              setState(() {
                _bottomNavIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
