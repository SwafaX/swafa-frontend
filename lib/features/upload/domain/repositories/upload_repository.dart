import 'dart:io';

abstract class UploadRepository {
  Future<void> uploadItem(String title, String description, List<File> images);
}