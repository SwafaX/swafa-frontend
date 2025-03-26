import 'dart:convert';
import 'package:swafa_app_frontend/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    super.description, // Fixed typo, optional with default
    required super.avatar,
    super.numSwaps, // Optional with default
    super.itemImages, // Optional with default
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '', // Default to empty string if null
      name: json['name'] ?? 'Unnamed', // Default to 'Unnamed' if null
      description: json['description'] ?? 'No description available', // Default value
      avatar: json['avatar_url'] ?? '', // Maps to backend 'avatar_url', default empty
      numSwaps: json['numSwaps'] ?? 0, // Default to 0
      itemImages: json['itemImages'] != null
          ? jsonDecode(json['itemImages'])
          : [], // Default to empty list
    );
  }
}