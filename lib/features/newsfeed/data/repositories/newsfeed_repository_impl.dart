import 'package:swafa_app_frontend/features/newsfeed/data/datasources/newsfeed_remote_data_source.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/entities/item_entity.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/repositories/newsfeed_repository.dart';

class NewsfeedRepositoryImpl implements NewsfeedRepository {
  final NewsfeedRemoteDataSource newsfeedRemoteDataSource;

  NewsfeedRepositoryImpl({required this.newsfeedRemoteDataSource});

  @override
  Future<List<ItemEntity>> fetchItems() async {
    return await newsfeedRemoteDataSource.fetchItems();
  }
}