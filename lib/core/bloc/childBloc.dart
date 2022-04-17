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

  void getChildren() async {
    var response = await childProvider.getAllChildsFromFather();
    changechildren(response);
  }
}
