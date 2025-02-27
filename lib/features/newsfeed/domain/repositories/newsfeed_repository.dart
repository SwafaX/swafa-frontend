import 'package:swafa_app_frontend/features/newsfeed/domain/entities/item_entity.dart';

abstract class NewsfeedRepository {
  Future<List<ItemEntity>> fetchItems();
}