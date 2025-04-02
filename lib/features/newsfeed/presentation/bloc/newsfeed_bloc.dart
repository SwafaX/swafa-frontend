import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/usecases/fetch_items_use_case.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/usecases/sendMessage_use_case.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_event.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_state.dart';

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  final FetchItemsUseCase fetchItemsUsecase;
  final SendmessageUseCase sendMessageUseCase; // Fixed typo in class name

  NewsfeedBloc({
    required this.fetchItemsUsecase,
    required this.sendMessageUseCase,
  }) : super(NewsfeedInitialState()) {
    on<FetchItemsEvent>(_onFetchItems);
    on<SwipeRightEvent>(_onSwipeRight);
    on<SendMessageEvent>(_onSendMessage);
    on<CancelMessageEvent>(_onCancelMessage);
  }

  Future<void> _onFetchItems(
      FetchItemsEvent event, Emitter<NewsfeedState> emit) async {
    emit(NewsfeedLoadingState());
    try {
      final items = await fetchItemsUsecase.call();
      emit(NewsfeedLoadedState(items: items));
    } catch (e) {
      emit(NewsfeedErrorState(message: 'Failed to load newsfeed items'));
    }
  }

  void _onSwipeRight(SwipeRightEvent event, Emitter<NewsfeedState> emit) {
    if (state is NewsfeedLoadedState) {
      final items = (state as NewsfeedLoadedState).items;
      emit(MessageInputState(items, event.itemId));
    }
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<NewsfeedState> emit) async {
    if (state is MessageInputState) {
      final items = (state as MessageInputState).items;
      emit(MessageSendingState(items));
      try {
        await sendMessageUseCase.call(event.itemId, event.message);
        emit(MessageSentState(items));
        emit(NewsfeedLoadedState(
            items: items)); // Reset to loaded state after success
      } catch (e) {
        emit(NewsfeedErrorState(message: 'Failed to send message: $e'));
      }
    }
  }

  void _onCancelMessage(CancelMessageEvent event, Emitter<NewsfeedState> emit) {
    if (state is MessageInputState || state is MessageSendingState) {
      final items = (state as dynamic).items; // Access items dynamically
      emit(NewsfeedLoadedState(items: items)); // Reset to loaded state
    }
  }
}
