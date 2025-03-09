import 'dart:io';

abstract class UploadEvent {}

class UploadItemEvent extends UploadEvent {
  final String title;
  final String description;
  final List<File> images;

  UploadItemEvent({
    required this.title,
    required this.description,
    required this.images,
  });
}
