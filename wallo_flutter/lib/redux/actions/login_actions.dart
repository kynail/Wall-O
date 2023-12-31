import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/achievement_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/services/login_service.dart';
import 'package:wallo_flutter/route_generator.dart';

import 'messenger_actions.dart';

ThunkAction logUser(String mail, String password) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      login(mail, password).then((user) {
        store.dispatch(
          new RequestSucceedActionWithMessage("Bienvenue, " + user.firstName),
        );
        store.dispatch(new LoginSuccessAction(user));
        if (user.newAchievement != null) {
          store.dispatch(SetNewAchievementAction(user.newAchievement));
          store.dispatch(SetUserLevelAction(user.newAchievement.game));
          store.dispatch(
            RequestSucceedActionWithMessage(user.newAchievement.message),
          );
        }
        Keys.navKey.currentState.pushReplacementNamed(Routes.home);
      }, onError: (errorMessage) {
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

ThunkAction registerUser(
    String name, String firstname, String mail, String passw) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      register(name, firstname, mail, passw).then((user) {
        print("OKAY user $user");
        store.dispatch(new RequestSucceedActionWithMessage(
            "Bienvenue, " + user.firstName));
        store.dispatch(new LoginSuccessAction(user));
        Keys.navKey.currentState.pushReplacementNamed(Routes.home);
      }, onError: (errorMessage) {
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

ThunkAction googleLogin(String requestUrl) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      googleRequest(requestUrl).then((user) {
        store.dispatch(
          new RequestSucceedActionWithMessage("Bienvenue, " + user.firstName),
        );
        print("USER $user");
        store.dispatch(new LoginSuccessAction(user));
        if (user.newAchievement != null) {
          store.dispatch(SetNewAchievementAction(user.newAchievement));
          store.dispatch(SetUserLevelAction(user.newAchievement.game));
          store.dispatch(
            RequestSucceedActionWithMessage(user.newAchievement.message),
          );
        }
        Keys.navKey.currentState.pushReplacementNamed(Routes.home);
      }, onError: (errorMessage) {
        print("ERROR GOOGLE LOGIN $errorMessage");
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

class LoginSuccessAction {
  final User user;

  LoginSuccessAction(this.user);
}
