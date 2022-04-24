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

class ChildExtraInfoDto {
  double? exposureTime;
  double? uvi;
  String? fps;
  ChildExtraInfoDto({
    required this.exposureTime,
    required this.uvi,
    required this.fps,
  });
  factory ChildExtraInfoDto.fromJson(Map<String, dynamic> childJson) {
    return ChildExtraInfoDto(
        exposureTime: childJson['exposureTime'] * 1.0,
        fps: childJson['fps'],
        uvi: childJson['uvi'] * 1.0);
  }
}
