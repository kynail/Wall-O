import 'package:camera/camera.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/services/user_service.dart';

ThunkAction setExp(User user, double exp) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      expRequest(user, exp).then((data) {
        user.level = data[0];
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
        print("CAMERAS $cameras");
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
            new RequestFailedAction("Connexion au serveur impossible"));
      }
    });
  };
}

// void setAvatar(Store<AppState> store, Avatar avatar, User user) async {
//   try {
//     store.dispatch(
//       SetUserStateAction(
//         UserState(isError: false, isLoading: true),
//       ),
//     );
//     final response = await http.put(Uri.http("localhost:8080", "/game/avatar"),
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'id': user.id, "type": avatar.type, "seed": avatar.seed});

//     if (response.statusCode == 201) {
//       user.avatar = avatar;

//       store.dispatch(
//         SetUserStateAction(
//           UserState(
//               isError: false,
//               isLoading: false,
//               user: user,
//               successMessage: "Votre avatar a correctement été modifié"),
//         ),
//       );
//     } else {
//       print("ERRROR");
//       store.dispatch(SetUserStateAction(UserState(
//           isError: true,
//           isLoading: false,
//           errorMessage: "Une erreur s'est produite, veuillez réessayer")));
//       return;
//     }
//   } on Exception catch (_) {
//     store.dispatch(SetUserStateAction(UserState(
//         isError: true,
//         isLoading: false,
//         errorMessage: "Une erreur s'est produite, veuillez réessayer")));
//     throw Exception("Connexion au serveur impossible");
//   }
// }

class UpdateUserAction {
  final User user;

  UpdateUserAction(this.user);
}

class SetCamerasAction {
  final List<CameraDescription> cameras;

  SetCamerasAction(this.cameras);
}
