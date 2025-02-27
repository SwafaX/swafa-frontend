import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/usecases/fetch_items_use_case.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_event.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_state.dart';

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  final FetchItemsUseCase fetchItemsUsecase;

  NewsfeedBloc({required this.fetchItemsUsecase})
      : super(NewsfeedInitialState()) {
    on<FetchItemsEvent>(_onFetchItems);
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
}
