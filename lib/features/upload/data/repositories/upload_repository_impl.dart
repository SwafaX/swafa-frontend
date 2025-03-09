import 'dart:io';

import 'package:swafa_app_frontend/features/upload/data/datasource/upload_remote_datasource.dart';
import 'package:swafa_app_frontend/features/upload/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl extends UploadRepository {
  final UploadRemoteDatasource uploadRemoteDatasource;

  UploadRepositoryImpl({required this.uploadRemoteDatasource});

  @override
  Future<void> uploadItem(String title, String description, List<File> images) async {
    await uploadRemoteDatasource.uploadItem(title: title, description: description, images: images);
  }
}
