import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/camera_manger_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;

  LifeCycleManager({Key key, this.child}) : super(key: key);
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  bool _needToInitCamera = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _needToInitCamera = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CameraManagerViewModel>(
      converter: (store) => CameraManagerViewModel.fromStore(store),
      builder: (_, viewModel) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_needToInitCamera == true) {
            viewModel.initializeCameraController();
            setState(() {
              _needToInitCamera = false;
            });
          }
        });
        return widget.child;
      },
    );
  }
}
