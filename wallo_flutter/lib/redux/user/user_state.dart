import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final User user;

  UserState({this.isError, this.errorMessage, this.isLoading, this.user});

  factory UserState.initial() => UserState(
      errorMessage: null, isLoading: false, isError: false, user: null);

  UserState copyWith({
    @required bool isError,
    @required String errorMessage,
    @required bool isLoading,
    @required User user,
  }) {
    return UserState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'UserState: {isError: $isError, errorMessage: $errorMessage, isloading: $isLoading, User: $user}';
  }
}
