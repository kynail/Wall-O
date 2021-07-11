import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/fish_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class HomeViewModel {
  final bool isCameraLoading;
  final List<CameraDescription> cameras;
  final CameraDescription selectedCamera;
  final User user;
  final Function() getAquadex;
  final CameraController cameraController;

  HomeViewModel({
    this.isCameraLoading,
    this.cameras,
    this.selectedCamera,
    this.cameraController,
    this.user,
    this.getAquadex,
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
    );
  }
}
