import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final String successMessage;
  final User user;

  UserState(
      {this.isError,
      this.errorMessage,
      this.isLoading,
      this.successMessage,
      this.user});

  factory UserState.initial() => UserState(
      errorMessage: null,
      isLoading: false,
      isError: false,
      user: null,
      successMessage: null);

  // UserState copyWith({
  //   @required bool isError,
  //   @required String errorMessage,
  //   @required String successMessage,
  //   @required bool isLoading,
  //   @required User user,
  // }) {
  //   return UserState(
  //     isError: isError ?? this.isError,
  //     errorMessage: errorMessage ?? this.errorMessage,
  //     successMessage: successMessage ?? this.successMessage,
  //     isLoading: isLoading ?? this.isLoading,
  //     user: user ?? this.user,
  //   );
  // }

  @override
  String toString() {
    return 'UserState: {isError: $isError, errorMessage: $errorMessage, isloading: $isLoading, User: $user, successMessage: $successMessage}';
  }
}
