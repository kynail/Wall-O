import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/fish_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class HomeViewModel {
  final List<CameraDescription> cameras;
  final CameraDescription selectedCamera;
  final Function() getCameras;
  final User user;
  final Function() getAquadex;

  HomeViewModel({
    this.cameras,
    this.getCameras,
    this.selectedCamera,
    this.user,
    this.getAquadex,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    final cameraList = store.state.userState.cameras;
    return HomeViewModel(
      user: store.state.userState.user,
      cameras: store.state.userState.cameras,
      selectedCamera: cameraList != null ? cameraList.first : null,
      getCameras: () => store.dispatch(getCamerasAction()),
      getAquadex: () => store.dispatch(getAquadexAction()),
    );
  }
}
