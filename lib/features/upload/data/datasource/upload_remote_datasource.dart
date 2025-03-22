import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UploadRemoteDatasource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  UploadRemoteDatasource({required this.baseUrl});

  Future<void> uploadItem({
    required String title,
    required String description,
    required List<File> images,
  }) async {
    String token = await _storage.read(key: 'accessToken') ?? '';

    print('Upload: test 1');
    print('Token: $token');

    if (token.isEmpty) {
      throw Exception('No token');
    }

    for (File image in images) {
      //Print file path
      String filename = image.path.split('/').last;
      print(filename);

      final response = await http.get(
        Uri.parse('$baseUrl/presigned-url?filename=${image.path.split('/').last}&file_type=item',),
        headers: {
            'Authorization': 'Bearer $token',
          },
      );

      //Print status code
      print('Upload: test 2');
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // Parse JSON response
        final presignedUrl = jsonDecode(response.body)['url'];
        print('Pre-signed URL: $presignedUrl');

        final uploadResponse = await http.put(
          Uri.parse(presignedUrl),
          body: await image.readAsBytes(),
          headers: {
            "Content-Type": "image/jpeg", // Adjust if needed
          },
        );

        print('test 3');
        print('Upload status: ${uploadResponse.statusCode}');
        print('Upload response: ${uploadResponse.body}');

        if (uploadResponse.statusCode != 200) {
          throw Exception('Upload failed: ${uploadResponse.statusCode}');
        }
      } else {
        throw Exception('Failed to get pre-signed URL: ${response.statusCode}');
      }
    }
  }
}