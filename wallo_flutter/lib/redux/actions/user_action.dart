import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/services/user_service.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

ThunkAction setExp(User user, double exp) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      expRequest(user, exp).then((data) {
        user = user.copyWith(level: data[0]);
        store.dispatch(new UpdateUserAction(user));
        store.dispatch(new RequestSucceedActionWithMessage(data[1]));
      }, onError: (errorMessage) {
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

ThunkAction getCamerasAction() {
  return (Store store) async {
    new Future(() async {
      try {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          store.dispatch(
              new RequestFailedAction("Aucun appareil photo disponible"));
        } else {
          store.dispatch(new SetCamerasAction(cameras));
        }
      } on Exception {
        store.dispatch(
            new RequestFailedAction("Impossible d'acceder à l'appareil photo"));
      }
    });
  };
}

ThunkAction<AppState> initializeCameraControllerAction() {
  return (Store<AppState> store) async {
    new Future(
      () async {
        try {
          store.dispatch(SetCameraLoadingAction());
          final cameraList = store.state.userState.cameras;
          CameraController controller = CameraController(
            cameraList != null ? cameraList.first : null,
            ResolutionPreset.medium,
          );
          await controller.initialize();
          controller.setFlashMode(FlashMode.off);
          store.dispatch(SetCameraControllerAction(controller));
          store.dispatch(SetCameraLoadingAction());
        } on Exception {
          store.dispatch(
            new RequestFailedAction("Impossible d'initialiser la camera"),
          );
        }
      },
    );
  };
}

ThunkAction setAvatar(Avatar avatar, User user) {
  return (Store store) async {
    new Future(() async {
      try {
        store.dispatch(new StartLoadingAction());
        setAvatarRequest(avatar, user).then((user) {
          store.dispatch(new UpdateUserAction(user));
          store.dispatch(new RequestSucceedActionWithMessage(
              "Votre avatar a correctement été modifié"));
        }).onError(
          (error, stackTrace) => store.dispatch(
            new RequestFailedAction(error),
          ),
        );
      } on Exception catch (_) {
        store.dispatch(
          new RequestFailedAction("Connexion au serveur impossible"),
        );
      }
    });
  };
}

ThunkAction sendForget(String email) {
  return (Store store) async {
    new Future(() async {
      try {
        store.dispatch(new StartLoadingAction());
        sendForgetRequest(email)
            .then(
              (message) => store.dispatch(
                new RequestSucceedActionWithMessage(message),
              ),
            )
            .onError(
              (error, stackTrace) => store.dispatch(
                new RequestFailedAction(error),
              ),
            );
      } on Exception catch (_) {
        store.dispatch(
          new RequestFailedAction("Connexion au serveur impossible"),
        );
      }
    });
  };
}

ThunkAction resetPassord(
    String password, String confirmPassword, String token) {
  return (Store store) async {
    new Future(
      () async {
        try {
          store.dispatch(new StartLoadingAction());
          resetPasswordRequest(password, confirmPassword, token)
              .then(
                (message) => store.dispatch(
                  new RequestSucceedActionWithMessage(message),
                ),
              )
              .onError(
                (error, stackTrace) => store.dispatch(
                  new RequestFailedAction(error),
                ),
              );
        } on Exception catch (_) {
          store.dispatch(
            new RequestFailedAction("Connexion au serveur impossible"),
          );
        }
      },
    );
  };
}

class UpdateUserAction {
  final User user;

  UpdateUserAction(this.user);
}

class SetUserAquadexAction {
  final List<String> aquadex;

  SetUserAquadexAction(this.aquadex);
}

class SetCamerasAction {
  final List<CameraDescription> cameras;

  SetCamerasAction(this.cameras);
}

class SetCameraControllerAction {
  final CameraController cameraController;

  SetCameraControllerAction(this.cameraController);
}

class SetCameraLoadingAction {
  SetCameraLoadingAction();
}
