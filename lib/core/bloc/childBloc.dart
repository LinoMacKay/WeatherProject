import 'package:my_project/core/provider/childProvider.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:rxdart/rxdart.dart';

class ChildBloc {
  ChildProvider childProvider = ChildProvider();

  BehaviorSubject<List<ChildDto>> _childrenController =
      BehaviorSubject<List<ChildDto>>();
  Stream<List<ChildDto>> get childrenStream => _childrenController.stream;
  Function(List<ChildDto>) get changechildren => _childrenController.sink.add;
  List<ChildDto> get children => _childrenController.value;

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
}
