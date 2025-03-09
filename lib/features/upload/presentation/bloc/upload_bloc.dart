import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/upload/domain/usecases/upload_use_case.dart';
import 'package:swafa_app_frontend/features/upload/presentation/bloc/upload_event.dart';
import 'package:swafa_app_frontend/features/upload/presentation/bloc/upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadUseCase uploadUseCase;

  UploadBloc({required this.uploadUseCase}) : super(UploadLoadingState()) {
    on<UploadItemEvent>(_onUpload);
  }

  Future<void> _onUpload(
      UploadItemEvent event, Emitter<UploadState> emit) async {
    emit(UploadLoadingState());
    try {
      await uploadUseCase.call(
        event.title,
        event.description,
        event.images,
      );
      emit(UploadSuccessState(message: 'Upload successfully'));
    } catch (e) {
      emit(UploadFailure(message: 'Upload failed'));
    }
  }
}
