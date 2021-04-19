import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final User user;

  UserState({@required this.user});

  factory UserState.initial() => new UserState(user: null);

  UserState copyWith({
    User user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  @override
  int get hashCode => user.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserState && user == other.user;

  @override
  String toString() {
    return 'UserState: {User: $user}';
  }
}
