class UpdateChildDto {
  int id = 0;
  String name = '';
  String birthday = '';

  UpdateChildDto({id, name,birthday});

  Map<String, dynamic> toJson() =>
      {'Id': id, 'Name': name, 'Birthday': birthday};


  factory UpdateChildDto.fromJson(Map<String, dynamic> childJson) {
    return UpdateChildDto(
        birthday: childJson['Birthday'],
        id: childJson['Id'],
        name: childJson['Name']);
  }
}
