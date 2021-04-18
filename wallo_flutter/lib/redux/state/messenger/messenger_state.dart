import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class MessengerState {
  final bool isLoading;
  final bool isError;
  final String successMessage;
  final String errorMessage;
  final bool showSnackbar;

  MessengerState({
    @required this.showSnackbar,
    @required this.isError,
    @required this.errorMessage,
    @required this.isLoading,
    @required this.successMessage,
  });

  factory MessengerState.initial() => new MessengerState(
      showSnackbar: false,
      errorMessage: null,
      isLoading: false,
      isError: false,
      successMessage: null);

  MessengerState copyWith({
    bool showSnackbar,
    bool isError,
    String errorMessage,
    String successMessage,
    bool isLoading,
  }) {
    return MessengerState(
        showSnackbar: showSnackbar ?? this.showSnackbar,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  String toString() {
    return 'MessengerState: {isError: $isError, showSnackbar: $showSnackbar, errorMessage: $errorMessage, isloading: $isLoading, successMessage: $successMessage}';
  }
}
