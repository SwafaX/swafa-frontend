import 'package:swafa_app_frontend/features/profile/data/datasource/profileItem_remote_datasource.dart';
import 'package:swafa_app_frontend/features/profile/data/models/item_profile_model.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemProfileRepositoty {
  final ItemRemoteDataSource itemRemoteDataSource;

  ItemRepositoryImpl({required this.itemRemoteDataSource});

  @override
  Future<List<ItemProfileModel>> fetchItem() async {
    return itemRemoteDataSource.fetchItems();
  }
}