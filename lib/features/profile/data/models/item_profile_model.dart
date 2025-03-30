import 'package:swafa_app_frontend/features/profile/domain/entities/item_profile_entity.dart';

class ItemProfileModel extends ItemProfileEntity {
  ItemProfileModel({
    required super.id,
    required super.title,
    super.description,
    required super.imageUrl,
    required super.userId,
  });

  factory ItemProfileModel.fromJson(Map<String, dynamic> json) {
    return ItemProfileModel(
      id: json['id'] ?? '', // Matches Item.ID
      title: json['title'] ?? 'Untitled', // Matches Item.Title
      description: json['description'] ?? 'No description available', // Matches Item.Description
      imageUrl: json['image_url'] ?? '', // Matches Item.ImageUrl
      userId: json['user_id'] ?? '', // Matches Item.UserID
    );
  }
}