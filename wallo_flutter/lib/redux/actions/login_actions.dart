import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/services/login_service.dart';
import 'package:wallo_flutter/route_generator.dart';

ThunkAction logUser(String mail, String password) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      login(mail, password).then((user) {
        print("OK LOGIN");
        store.dispatch(new LoginSuccessAction(user));
        Keys.navKey.currentState.pushNamed(Routes.home);
      }, onError: (errorMessage) {
        store.dispatch(new LoginFailedAction(errorMessage));
      });
    });
  };
}

class StartLoadingAction {
  StartLoadingAction();
}

class LoginSuccessAction {
  final User user;

  LoginSuccessAction(this.user);
}

class LoginFailedAction {
  final String errorMessage;

  LoginFailedAction(this.errorMessage);
}

class MarkSnackbarHasHandledAction {
  MarkSnackbarHasHandledAction();
}
