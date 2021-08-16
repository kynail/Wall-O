import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:wallo_flutter/models/user.dart';

@immutable
class UserState {
  final User user;
  final List<CameraDescription> cameras;
  final CameraController cameraController;
  final bool isCameraLoading;

  UserState({
    @required this.user,
    @required this.cameras,
    @required this.cameraController,
    @required this.isCameraLoading,
  });

  factory UserState.initial() => new UserState(
        user: null,
        cameras: null,
        cameraController: null,
        isCameraLoading: false,
      );

  UserState copyWith({
    User user,
    List<CameraDescription> cameras,
    CameraController cameraController,
    bool isCameraLoading,
  }) {
    return UserState(
      cameras: cameras ?? this.cameras,
      user: user ?? this.user,
      cameraController: cameraController ?? this.cameraController,
      isCameraLoading: isCameraLoading ?? this.isCameraLoading,
    );
  }

  @override
  int get hashCode {
    return user.hashCode ^
        cameras.hashCode ^
        cameraController.hashCode ^
        isCameraLoading.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.user == user &&
        listEquals(other.cameras, cameras) &&
        other.cameraController == cameraController &&
        other.isCameraLoading == isCameraLoading;
  }

  @override
  String toString() {
    return 'UserState(user: $user, cameras: $cameras, cameraController: $cameraController, isCameraLoading: $isCameraLoading)';
  }
}
