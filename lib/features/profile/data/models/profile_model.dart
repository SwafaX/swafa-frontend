import 'package:swafa_app_frontend/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    required super.desciption,
    required super.avatar,
    required super.numSwaps,
    // required super.itemImages,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      desciption: json['description'],
      avatar: json['avatar'],
      numSwaps: json['numSwaps'],
      // itemImages: jsonDecode(json['itemImages']),
    );
  }
}
