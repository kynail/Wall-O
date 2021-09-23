import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, UpdateUserAction>(_updateUser),
  TypedReducer<UserState, SetCamerasAction>(_setCameras),
  TypedReducer<UserState, SetCameraControllerAction>(_setCameraController),
  TypedReducer<UserState, SetCameraLoadingAction>(_setCameraLoading),
  TypedReducer<UserState, SetUserAquadexAction>(_setUserAquadex),
  TypedReducer<UserState, SetUserLevelAction>(_setUserLevel),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
    user: action.user,
  );
}

UserState _updateUser(UserState state, UpdateUserAction action) {
  return state.copyWith(
    user: action.user,
  );
}

UserState _setCameras(UserState state, SetCamerasAction action) {
  return state.copyWith(
    cameras: action.cameras,
  );
}

UserState _setCameraController(
    UserState state, SetCameraControllerAction action) {
  return state.copyWith(
    cameraController: action.cameraController,
  );
}

UserState _setCameraLoading(UserState state, SetCameraLoadingAction action) {
  return state.copyWith(
    isCameraLoading: !state.isCameraLoading,
  );
}

UserState _setUserAquadex(UserState state, SetUserAquadexAction action) {
  return state.copyWith(user: state.user.copyWith(aquadex: action.aquadex));
}

UserState _setUserLevel(UserState state, SetUserLevelAction action) {
  return state.copyWith(user: state.user.copyWith(level: action.level));
}
