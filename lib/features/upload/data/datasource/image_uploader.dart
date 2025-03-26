import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ImageUploader {
  final String baseUrl;
  final FlutterSecureStorage _storage;

  ImageUploader({required this.baseUrl, required FlutterSecureStorage storage})
      : _storage = storage;

  Future<List<String>> uploadImages(List<File> images, String token) async {
    List<String> uploadedImageUrls = [];

    for (File image in images) {
      // File validation
      print('Image: $image');
      print('File exists: ${image.existsSync()}');
      if (!image.existsSync()) {
        print('File does not exist!');
        throw Exception('Image file missing: ${image.path}');
      }
      int fileSize = await image.length();
      print('File size: $fileSize bytes');

      // Get pre-signed URL
      String filename = image.path.split('/').last;
      print('Filename: $filename');
      final response = await http.get(
        Uri.parse('$baseUrl/presigned-url?filename=$filename&file_type=item'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to get pre-signed URL: ${response.statusCode}');
      }

      // Adjust URL and upload
      final presignedUrl = jsonDecode(response.body)['url'];
      print('Pre-signed URL: $presignedUrl');
      String adjustedUrl = presignedUrl; // .replaceAll('localhost:9000', 'minio.suba-server.org');
      print('Adjusted URL: $adjustedUrl');

      try {
        // Double-check file before PUT
        if (!image.existsSync()) {
          print('File missing before PUT!');
          throw Exception('File disappeared before upload: ${image.path}');
        }
        print('Starting PUT with $fileSize bytes');
        final uploadResponse = await http.put(
          Uri.parse(adjustedUrl),
          body: await image.readAsBytes(),
          headers: {"Content-Type": "image/jpg"},
        );

        print('Upload status: ${uploadResponse.statusCode}');
        print('Upload body: ${uploadResponse.body}');

        if (uploadResponse.statusCode != 200) {
          throw Exception('Upload failed: ${uploadResponse.statusCode} - ${uploadResponse.body}');
        }

        // Store the uploaded image reference
        uploadedImageUrls.add(filename); // Or use `adjustedUrl` if backend needs the full URL
      } catch (e) {
        print('PUT error: $e');
        rethrow;
      }
    }

    return uploadedImageUrls;
  }
}