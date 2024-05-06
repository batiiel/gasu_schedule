part of 'rasp_bloc.dart';

@immutable
abstract class RaspEvent {}

// ignore: must_be_immutable
class GetRaspEvent extends RaspEvent {
  final int id;
  final TypeRasp type;
  String date;

  GetRaspEvent({required this.id, required this.type, this.date = ''});
}

class SetIndexEvent extends RaspEvent {
  final int index;

  SetIndexEvent({required this.index});
}
