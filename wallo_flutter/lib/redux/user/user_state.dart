import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final bool showSnackbar;
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final String successMessage;
  final User user;

  UserState(
      {@required this.showSnackbar,
      @required this.isError,
      @required this.errorMessage,
      @required this.isLoading,
      @required this.successMessage,
      @required this.user});

  factory UserState.initial() => new UserState(
      showSnackbar: false,
      errorMessage: null,
      isLoading: false,
      isError: false,
      user: null,
      successMessage: null);

  UserState copyWith({
    bool showSnackbar,
    bool isError,
    String errorMessage,
    String successMessage,
    bool isLoading,
    User user,
  }) {
    return UserState(
      showSnackbar: showSnackbar ?? this.showSnackbar,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          showSnackbar == other.showSnackbar &&
          isError == other.isError &&
          successMessage == other.successMessage &&
          isLoading == other.isLoading &&
          user == other.user;

  @override
  int get hashCode => isLoading.hashCode ^ user.hashCode;

  @override
  String toString() {
    return 'UserState: {isError: $isError, showSnackbar: $showSnackbar, errorMessage: $errorMessage, isloading: $isLoading, User: $user, successMessage: $successMessage}';
  }
}
