abstract class NewsfeedEvent {}

class FetchItemsEvent extends NewsfeedEvent {}

class SwipeRightEvent extends NewsfeedEvent {
  final String itemId;

  SwipeRightEvent({required this.itemId});
}

class SendMessageEvent extends NewsfeedEvent {
  final String itemId;
  final String message;

  SendMessageEvent({required this.itemId, required this.message});
}

class CancelMessageEvent extends NewsfeedEvent {}
