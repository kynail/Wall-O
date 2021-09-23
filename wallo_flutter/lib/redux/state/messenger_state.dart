import 'package:meta/meta.dart';

@immutable
class MessengerState {
  final bool isLoading;
  final bool isError;
  final String successMessage;
  final String errorMessage;
  final bool showSnackbar;
  final bool showConfetti;

  MessengerState({
    @required this.showSnackbar,
    @required this.isError,
    @required this.errorMessage,
    @required this.isLoading,
    @required this.successMessage,
    @required this.showConfetti,
  });

  factory MessengerState.initial() => new MessengerState(
        showSnackbar: false,
        errorMessage: null,
        isLoading: false,
        isError: false,
        successMessage: null,
        showConfetti: false,
      );

  MessengerState copyWith({
    bool isLoading,
    bool isError,
    String successMessage,
    String errorMessage,
    bool showSnackbar,
    bool showConfetti,
  }) {
    return MessengerState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      showSnackbar: showSnackbar ?? this.showSnackbar,
      showConfetti: showConfetti ?? this.showConfetti,
    );
  }

  @override
  String toString() {
    return 'MessengerState: {isError: $isError, showSnackbar: $showSnackbar, errorMessage: $errorMessage, isloading: $isLoading, successMessage: $successMessage}';
  }
}
