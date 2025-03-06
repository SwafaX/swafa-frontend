import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/profile/domain/usecase/fetch_profile_use_case.dart';
import 'package:swafa_app_frontend/features/profile/presentation/bloc/profile_event.dart';
import 'package:swafa_app_frontend/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileUseCase fetchProfileUseCase;

  ProfileBloc({required this.fetchProfileUseCase})
      : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final profile = await fetchProfileUseCase.call();
      emit(ProfileLoadedState(profile: profile));
    } catch (e) {
      emit(ProfileErrorState(message: 'Failed to load profile'));
    }
  }
}
