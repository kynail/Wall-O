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
      {@required this.isError,
      @required this.errorMessage,
      @required this.isLoading,
      @required this.successMessage,
      @required this.user});

  factory UserState.initial() => new UserState(
      errorMessage: null,
      isLoading: false,
      isError: false,
      user: null,
      successMessage: null);

  UserState copyWith({
    @required bool isError,
    @required String errorMessage,
    @required String successMessage,
    @required bool isLoading,
    @required User user,
  }) {
    return UserState(
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
          isError == other.isError &&
          successMessage == other.successMessage &&
          isLoading == other.isLoading &&
          user == other.user;

  @override
  int get hashCode => isLoading.hashCode ^ user.hashCode;

  @override
  String toString() {
    return 'UserState: {isError: $isError, errorMessage: $errorMessage, isloading: $isLoading, User: $user, successMessage: $successMessage}';
  }
}
