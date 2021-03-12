import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final bool isError;
  final bool isLoading;
  final User user;

  UserState({this.isError, this.isLoading, this.user});

  factory UserState.initial() =>
      UserState(isLoading: false, isError: false, user: User());

  UserState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required User user,
  }) {
    return UserState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
