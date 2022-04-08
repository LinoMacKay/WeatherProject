import 'package:my_project/core/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class CreateChildBloc with Validators {
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);

  Function(String) get changeName => _nameController.sink.add;

  String get name => _nameController.value;

  dispose() {
    _nameController.close();
  }
}
