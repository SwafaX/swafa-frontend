import 'package:swafa_app_frontend/features/profile/domain/entities/item_profile_entity.dart';

abstract class ItemProfileRepositoty {
  Future<List<ItemProfileEntity>> fetchItem();
}