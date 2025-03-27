import 'package:swafa_app_frontend/features/profile/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.description,
    required super.numSwaps,

  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? '', // Matches User.ID
      name: json['name'] ?? 'Unnamed', // Matches User.Name
      avatar: json['avatar_url'] ?? '', // Matches User.AvatarUrl
      description: json['description'] ?? 'No description',
      numSwaps: json['numSwaps'] ?? 0, // Kept from original ProfileModel
    );
  }
}