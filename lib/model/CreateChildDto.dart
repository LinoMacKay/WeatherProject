class CreateChildDto {
  String name = '';
  String birthday = '';
  String score = '';

  Map<String, dynamic> toJson() =>
      {'Name': name, 'Birthday': birthday, 'Score': score};
}
