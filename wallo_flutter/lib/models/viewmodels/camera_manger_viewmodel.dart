import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class CameraManagerViewModel {
  final List<CameraDescription> cameras;
  final CameraDescription selectedCamera;
  final CameraController cameraController;
  final Function() getCameras;
  final Function() initializeCameraController;

  CameraManagerViewModel({
    this.cameras,
    this.getCameras,
    this.selectedCamera,
    this.initializeCameraController,
    this.cameraController,
  });

  static CameraManagerViewModel fromStore(Store<AppState> store) {
    final cameraList = store.state.userState.cameras;
    return CameraManagerViewModel(
      cameras: store.state.userState.cameras,
      selectedCamera: cameraList != null ? cameraList.first : null,
      getCameras: () => store.dispatch(getCamerasAction()),
      initializeCameraController: () =>
          store.dispatch(initializeCameraControllerAction()),
      cameraController: store.state.userState.cameraController,
    );
  }
}
