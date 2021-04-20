import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final User user;
  final List<CameraDescription> cameras;

  UserState({@required this.user, @required this.cameras});

  factory UserState.initial() => new UserState(user: null, cameras: null);

  UserState copyWith({User user, List<CameraDescription> cameras}) {
    return UserState(
      cameras: cameras ?? this.cameras,
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
