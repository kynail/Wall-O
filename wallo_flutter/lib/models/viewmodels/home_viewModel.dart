import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/new_achievement.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/achievement_actions.dart';
import 'package:wallo_flutter/redux/actions/fish_actions.dart';
import 'package:wallo_flutter/redux/actions/game_actions.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class HomeViewModel {
  final bool isCameraLoading;
  final List<CameraDescription> cameras;
  final CameraDescription selectedCamera;
  final User user;
  final Function() getAquadex;
  final Function() getAchievements;
  final Function() newAchievementShowed;
  final Function() getLeaderboard;
  final CameraController cameraController;
  final NewAchievement newAchievement;
  final Function() onDisconnect;

  HomeViewModel({
    this.isCameraLoading,
    this.cameras,
    this.selectedCamera,
    this.cameraController,
    this.user,
    this.getAquadex,
    this.getAchievements,
    this.newAchievementShowed,
    this.newAchievement,
    this.getLeaderboard,
    this.onDisconnect,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    final cameraList = store.state.userState.cameras;
    return HomeViewModel(
      isCameraLoading: store.state.userState.isCameraLoading,
      user: store.state.userState.user,
      cameras: store.state.userState.cameras,
      cameraController: store.state.userState.cameraController,
      selectedCamera: cameraList != null ? cameraList.first : null,
      getAquadex: () => store.dispatch(
        getAquadexAction(),
      ),
      getAchievements: () => store.dispatch(
        getAchievementAction(),
      ),
      newAchievementShowed: () => store.dispatch(
        NewAchievementShowedAction(),
      ),
      newAchievement: store.state.achievementState.newAchievement,
      getLeaderboard: () => store.dispatch(
        getLeaderboardAction(),
      ),
    );
  }
}
