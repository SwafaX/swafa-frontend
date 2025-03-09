import 'package:swafa_app_frontend/features/newsfeed/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.imageUrl
      // required super.userId,
      });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl']
        // userId: json['userId'],
        );
  }
}
