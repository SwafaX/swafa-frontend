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

    print('test 1');
    print('Token: $token');

    for (File image in images) {
      print(image.path.split('/').last);
      final response = await http.get(
        Uri.parse('$baseUrl/presigned-url?filename=${image.path.split('/').last}&file_type=item',),
        headers: {
            'Authorization': 'Bearer $token',
          },
      );

      print('test 2');

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final presignedUrl = response.body;

        final uploadResponse = await http.put(
          Uri.parse(presignedUrl),
          body: await image.readAsBytes(), // Send binary data
          headers: {
            "Content-Type": "image/jpeg", // Change based on file type
          },
        );
      } else {
        throw Exception('Failed to get pre-signed URL');
      }
      print('test 3');
    }
  }
}
