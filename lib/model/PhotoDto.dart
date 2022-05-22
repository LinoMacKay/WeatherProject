class PhotoDto {
  int estimatedMed = 0;
  String skinType = '';
  PhotoDto({
    required this.skinType,
    required this.estimatedMed,
  });
  factory PhotoDto.fromJson(Map<String, dynamic> childJson) {
    return PhotoDto(
        skinType: childJson['skinType'],
        estimatedMed: childJson['estimatedMed']);
  }
}
