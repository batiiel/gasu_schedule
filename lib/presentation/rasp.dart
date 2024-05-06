import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/constants.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/internal/dependecies/rasp_module.dart';
import 'package:gagu_schedule/domain/bloc/rasp_bloc/rasp_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RaspPage extends StatefulWidget {
  const RaspPage(
      {super.key, required this.name, required this.id, required this.type});
  final String name;
  final int id;
  final TypeRasp type;

  @override
  State<RaspPage> createState() => _RaspPageState();
}

class _RaspPageState extends State<RaspPage> {
  DateTime? tempDate;
  int weekDayIndex = -1;
  late RaspState stateRasp;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    tempDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final RaspBloc raspBloc = RaspModule.raspBloc();

    return BlocProvider<RaspBloc>(
      create: (context) {
        String strDate = DateFormat('yyyy-MM-dd').format(tempDate!);
        return raspBloc
          ..add(GetRaspEvent(id: widget.id, type: widget.type,date: strDate,));
      },
      child: 
      BlocBuilder<RaspBloc, RaspState>(
        builder: (context, state) {
        final raspBloc = BlocProvider.of<RaspBloc>(context);
        stateRasp = state;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorApp.barBackroud,
            automaticallyImplyLeading: false,
            title: Center(
                child: Text(
              widget.name,
              style: const TextStyle(
                color: ColorApp.textActive,
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
              ),
            )),
            actions: [
               IconButton(
                    onPressed: () async {
                      tempDate = await showDatePicker(
                        context: context,
                        locale: const Locale("ru"),
                        initialDate: tempDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (tempDate != null) {
                        String strDate =
                            DateFormat('yyyy-MM-dd').format(tempDate!);
                        raspBloc.add(GetRaspEvent(
                              id: widget.id,
                              date: strDate,
                              type: widget.type,
                            ));
                        setState(() {
                          weekDayIndex = state.indexWeek;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
            ],
          ),
          backgroundColor: ColorApp.mainBackroud,
          body: getBody(),
        );
        },
      ),
    );
  }

  Widget getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        dateInput(),
        const SizedBox(
          height: 10.0,
        ),
        listGroup(),
      ],
    );
  }

  Widget dateInput() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: ColorApp.barBackroud,
        borderRadius: BorderRadius.zero,
      ),
      height: 100,
      child: Center(
        child: Builder(
          builder: (context) {
            return ListView.builder(
              itemCount: stateRasp.week.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final boxColor = index == stateRasp.indexWeek
                    ? ColorApp.active
                    : ColorApp.barBackroud;
                final textColor = index == stateRasp.indexWeek
                    ? ColorApp.textBalck
                    : ColorApp.textActive2;
                final circleColor =
                    stateRasp.week[index].rasp.isNotEmpty ? textColor : boxColor;
                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: boxColor, borderRadius: BorderRadius.circular(10)),
                  height: 80,
                  width: 55,
                  child: InkWell(
                    onTap: () {
                      context.read<RaspBloc>().add(SetIndexEvent(index: index));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          stateRasp.week[index].day,
                          style: TextStyle(fontSize: 24, color: textColor),
                        ),
                        Text(
                          stateRasp.week[index].weekDay,
                          style: TextStyle(color: textColor),
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: circleColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget listGroup() {
    return Expanded(
      child: Center(
        child: Builder(
          builder: (context) {
            if(stateRasp.isLoading){
              return const CircularProgressIndicator();
            }
            if (stateRasp.week.isNotEmpty) {
              final rasp = stateRasp.week[stateRasp.indexWeek].rasp;
              return ListView.builder(
                itemCount: rasp.length,
                itemBuilder: (BuildContext context, int index) {
                  return lesson(rasp, index);
                },
              );
            }
            return const Text("Нет данных");
          },
        ),
      ),
    );
  }

  Widget lesson(List<Rasp> rasp, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: RadiusApp.radiusItem,
        color: ColorApp.barBackroud,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        rasp[index].start_time,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: ColorApp.textActive2,
                        ),
                      ),
                      Text(
                        rasp[index].end_time,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: ColorApp.textActive2,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: rasp[index].color,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          rasp[index].discipline,
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: rasp[index].color,
                          ),
                        ),
                      ),
                      Text(
                        "преп: ${rasp[index].teacher}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: ColorApp.textActive2,
                        ),
                      ),
                      Text(
                        "каб: ${rasp[index].classroom}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: ColorApp.textActive2,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "гр: ${rasp[index].group}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: ColorApp.textActive2,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}