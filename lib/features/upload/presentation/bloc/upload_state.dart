abstract class UploadState {}

class UploadLoadingState extends UploadState {}

class UploadSuccessState extends UploadState {
    String message;

    UploadSuccessState({required this.message});
}

class UploadFailure extends UploadState {
    String message;

    UploadFailure({required this.message});
}