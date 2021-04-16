import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/services/login_service.dart';

ThunkAction logUser(String mail, String password) {
  return (Store store) async {
    new Future(() async {
      print("LOG USER");
      print(mail);
      print(password);
      store.dispatch(new StartLoadingAction());
      login(mail, password).then((user) {
        store.dispatch(new LoginSuccessAction(user));
        // Keys.navKey.currentState.pushNamed(Routes.homeScreen);
      }, onError: (error) {
        store.dispatch(new LoginFailedAction());
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
  LoginFailedAction();
}
