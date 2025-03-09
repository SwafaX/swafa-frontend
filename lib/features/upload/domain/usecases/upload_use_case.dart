import 'dart:io';

import 'package:swafa_app_frontend/features/upload/domain/repositories/upload_repository.dart';

class UploadUseCase {
  final UploadRepository uploadRepository;

  UploadUseCase({required this.uploadRepository});

  Future<void> call(String title, String description, List<File> images) {
    return uploadRepository.uploadItem(title, description, images);
  }
  
}