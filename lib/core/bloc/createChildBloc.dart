import 'dart:async';
import 'dart:ffi';

import 'package:my_project/core/bloc/validators.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/core/provider/childProvider.dart';
import 'package:my_project/model/CreateChildDto.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/UpdateChildDto.dart';
import '../provider/childProvider.dart';

class CreateChildBloc with Validators {
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Function(String) get changeName => _nameController.sink.add;
  String get name => _nameController.value;

  final _birthdayController = BehaviorSubject<String>();
  Stream<String> get birthdayStream =>
      _birthdayController.stream.transform(validateBirthday);
  Function(String) get changeBirthday => _birthdayController.sink.add;
  Sink<String> get sinkBirthday => _birthdayController.sink;
  String get getBirthday => _birthdayController.value;

  final validateBirthday =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (true) {
      hasEnoughAge(value)
          ? sink.add(value)
          : sink.addError('Debe ser mayor de 14 años');
    }
  });
  static bool hasEnoughAge(String date) {
    DateTime birthDay = DateTime.parse(date);
    DateTime today = DateTime.now();

    int totalDays = today.difference(birthDay).inDays;

    int years = totalDays ~/ 365;

    return years >= 0;
  }

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(nameStream, birthdayStream, (e, p) => true);

  Future<bool> updateChild(UpdateChildDto updateChildDto) async {
    var response = await ChildProvider().updateChild(updateChildDto);
    return response;
  }

  Future<bool> createChild(CreateChildDto createChildDto) async {
    var response = await ChildProvider().createChild(createChildDto);
    return response;
  }

  Future<bool> deleteChild(childId) async {
    var response = await ChildProvider().deleteChild(childId);
    return response;
  }

  dispose() {
    _nameController.close();
    _birthdayController.close();
  }
}
