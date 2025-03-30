import 'package:swafa_app_frontend/features/newsfeed/domain/entities/item_entity.dart';

abstract class NewsfeedState {}

class NewsfeedInitialState extends NewsfeedState {}

class NewsfeedLoadingState extends NewsfeedState {}

class NewsfeedLoadedState extends NewsfeedState {
  final List<ItemEntity> items;

  NewsfeedLoadedState({required this.items});
}

class NewsfeedErrorState extends NewsfeedState {
  final String message;

  NewsfeedErrorState({required this.message});
}

class MessageInputState extends NewsfeedState {
  final List<ItemEntity> items;
  final String currentItemId;
  MessageInputState(this.items, this.currentItemId);
}

class MessageSendingState extends NewsfeedState {
  final List<ItemEntity> items;
  MessageSendingState(this.items);
}

class MessageSentState extends NewsfeedState {
  final List<ItemEntity> items;
  MessageSentState(this.items);
}
