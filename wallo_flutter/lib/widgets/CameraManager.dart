import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/camera_manger_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class CameraManager extends StatefulWidget {
  final Widget child;
  final Function(Future<void> initializeControllerFuture)
      onInitializeControllerFuture;

  CameraManager({
    Key key,
    this.child,
    this.onInitializeControllerFuture,
  }) : super(key: key);

  @override
  _CameraManagerState createState() => _CameraManagerState();
}

class _CameraManagerState extends State<CameraManager> {
  CameraController _controller;

  Future<void> initializeCamera(CameraManagerViewModel viewModel) {
    CameraDescription camera = viewModel.selectedCamera;

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    return _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CameraManagerViewModel>(
      distinct: true,
      converter: (store) => CameraManagerViewModel.fromStore(store),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel.selectedCamera != newViewModel.selectedCamera) {
          newViewModel.initializeCameraController();
        }
      },
      builder: (_, viewModel) {
        return viewModel.cameraController != null
            ? widget.child
            : Center(
                child: CircularProgressIndicator(),
              );
      },
      onInitialBuild: (viewModel) {
        viewModel.getCameras();
      },
    );
  }
}
