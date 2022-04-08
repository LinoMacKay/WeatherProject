import 'package:my_project/core/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class CreateChildBloc with Validators {
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<String> _dateController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);

  Stream<String> get dateStream =>
      _dateController.stream.transform(validateBirthDate);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDate => _dateController.sink.add;

  String get name => _nameController.value;
  String get date => _dateController.value;

  dispose() {
    _dateController.close();
    _nameController.close();
  }
}
