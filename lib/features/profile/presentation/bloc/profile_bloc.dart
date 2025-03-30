import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/profile/domain/usecase/fetch_item_use_case.dart';
import 'package:swafa_app_frontend/features/profile/domain/usecase/fetch_profile_use_case.dart';
import 'package:swafa_app_frontend/features/profile/presentation/bloc/profile_event.dart';
import 'package:swafa_app_frontend/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileUseCase fetchProfileUseCase;
  final FetchItemProfileUseCase fetchItemUseCase;

  ProfileBloc({required this.fetchProfileUseCase, required this.fetchItemUseCase})
      : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final profile = await fetchProfileUseCase.call();
      final items = await fetchItemUseCase.call();
      emit(ProfileLoadedState(profile: profile, items: items));
    } catch (e) {
      emit(ProfileErrorState(message: 'Failed to load profile'));
    }
  }
}
