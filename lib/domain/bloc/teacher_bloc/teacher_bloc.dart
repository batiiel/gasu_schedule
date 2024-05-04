import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:gagu_schedule/domain/model/Teacher.dart';
import 'package:gagu_schedule/domain/repository/teacher_repository.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (evetns, mapper) {
    return droppable<E>().call(evetns.debounce(duration), mapper);
  };
}

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final TeacherRepository _teacherReposioty;

  TeacherBloc(this._teacherReposioty) : super(TeacherState()) {
    on<GetTeacherEvent>(_onGetTeachers);
    on<SearchTeacherEvent>(_onSearch,
        transformer: debounceDroppable(const Duration(milliseconds: 300)));
  }

  _onGetTeachers(GetTeacherEvent event, Emitter<TeacherState> emit) async {
    final List<Teacher> teachers = await _teacherReposioty.getTeacherList();
    emit(TeacherState(teachers: teachers));
  }

  _onSearch(SearchTeacherEvent event, Emitter<TeacherState> emit) async {
    final List<Teacher> teachers = await _teacherReposioty.getTeacherList();
    final result = teachers
        .where((element) =>
            element.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(TeacherState(teachers: result));
  }
}
