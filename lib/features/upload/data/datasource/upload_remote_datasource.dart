import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'image_uploader.dart';
import 'item_uploader.dart';

class UploadRemoteDatasource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();
  late final ImageUploader _imageUploader;
  late final ItemUploader _itemUploader;

  UploadRemoteDatasource({required this.baseUrl}) {
    _imageUploader = ImageUploader(baseUrl: baseUrl, storage: _storage);
    _itemUploader = ItemUploader(baseUrl: baseUrl, storage: _storage);
  }

  Future<void> uploadItem({
    required String title,
    required String description,
    required List<File> images,
  }) async {
    // Fetch token
    String? token = await _storage.read(key: 'accessToken');
    if (token == null || token.isEmpty) {
      throw Exception('No token found');
    }

    // Upload images and get references
    List<String> uploadedImageUrls = await _imageUploader.uploadImages(images, token);

    // Use only the first image URL (since backend expects a single image_url)
    if (uploadedImageUrls.isEmpty) {
      throw Exception('No images uploaded successfully');
    }
    String imageUrl = uploadedImageUrls.first;

    // Upload item data (title, description, and single image URL)
    await _itemUploader.uploadItemData(title, description, imageUrl, token);
  }
}