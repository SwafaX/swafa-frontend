import 'dart:io';

class UploadEntity {
  final String id;
  final String title;
  final String description;
  final List<File> images;

  UploadEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.images});
}
