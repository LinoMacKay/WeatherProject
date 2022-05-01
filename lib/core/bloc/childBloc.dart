// ignore: file_names
import 'package:intl/intl.dart';
import 'package:my_project/core/provider/childProvider.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:rxdart/rxdart.dart';

class ChildBloc {
  ChildProvider childProvider = ChildProvider();

  // ignore: prefer_final_fields
  BehaviorSubject<List<ChildDto>> _childrenController =
      BehaviorSubject<List<ChildDto>>();
  Stream<List<ChildDto>> get childrenStream => _childrenController.stream;
  Function(List<ChildDto>) get changechildren => _childrenController.sink.add;
  List<ChildDto> get children => _childrenController.value;

  // ignore: prefer_final_fields
  BehaviorSubject<ChildExtraInfoDto> _childController =
      BehaviorSubject<ChildExtraInfoDto>();
  Stream<ChildExtraInfoDto> get childStream => _childController.stream;
  Function(ChildExtraInfoDto) get changechild => _childController.sink.add;
  ChildExtraInfoDto get child => _childController.value;

  void getChildren(userId) async {
    var response = await childProvider.getAllChildsFromFather(userId);
    changechildren(response);
  }

  void getSingleChild(childId, uvi) async {
    var response = await childProvider.getSingleChild(childId, uvi);
    changechild(response);
  }

  int getEdad(birthday) {
    var fecha = DateTime.tryParse(birthday);
    final now = DateTime.now();

    int years = now.year - fecha!.year;
    int months = now.month - fecha.month;
    int days = now.day - fecha.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = DateTime(now.year, now.month - 1, fecha.day);
      days = now.difference(monthAgo).inDays + 1;
    }

    return years;
  }

  String formatNacimiento(birthday) {
    var fecha = DateTime.tryParse(birthday);
    return fecha!.day.toString() +
        " de " +
        DateFormat('MMMM', 'es_ES').format(DateTime.tryParse(birthday)!) +
        " del " +
        fecha.year.toString();
  }
}
