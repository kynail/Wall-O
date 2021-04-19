import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
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
        store.dispatch(new RequestSucceedAction(data[1]));
      }, onError: (errorMessage) {
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

class UpdateUserAction {
  final User user;

  UpdateUserAction(this.user);
}
