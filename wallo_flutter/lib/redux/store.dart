import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/reducers/app_reducer.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/user/user_state.dart';
import 'package:redux_thunk/redux_thunk.dart';

class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final userStateInitial = UserState.initial();
    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: new AppState.initial(),
    );
  }
}
