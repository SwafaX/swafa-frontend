import 'package:swafa_app_frontend/features/profile/domain/entities/item_profile_entity.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/item_repository.dart';

class FetchItemProfileUseCase {
  final ItemProfileRepositoty itemProfileRepositoty;

  FetchItemProfileUseCase({required this.itemProfileRepositoty});

  Future<List<ItemProfileEntity>> call() {
    return itemProfileRepositoty.fetchItem();
  }
}