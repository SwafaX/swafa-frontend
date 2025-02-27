import 'package:swafa_app_frontend/features/newsfeed/domain/entities/item_entity.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/repositories/newsfeed_repository.dart';

class FetchItemsUseCase {
  final NewsfeedRepository repository;

  FetchItemsUseCase({required this.repository});

  Future<List<ItemEntity>> call() {
    return repository.fetchItems();
  }
}