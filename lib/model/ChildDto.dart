class ChildDto {
  String name = '';
  String birthday = '';
  String score = '';
  String scoreDescription = '';
  int id = 0;
  ChildDto({
    required this.name,
    required this.birthday,
    required this.score,
    required this.id,
    required this.scoreDescription});

  factory ChildDto.fromJson(Map<String, dynamic> childJson) {
    return ChildDto(
        birthday: childJson['birthday'],
        id: childJson['id'],
        name: childJson['name'],
        score: childJson['score'],
        scoreDescription: childJson['scoreDescription']);
  }
}
