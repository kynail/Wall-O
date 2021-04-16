import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';
import 'package:wallo_flutter/redux/user/user_reducer.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetUserStateAction) {
    final nextUserState = userReducer(state.userState, action);

    return state.copyWith(userState: nextUserState);
  }

  return state;
}

@immutable
class AppState {
  final UserState userState;

  AppState({
    @required this.userState,
  });

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial(),
    );
  }

  AppState copyWith({
    UserState userState,
  }) {
    return AppState(
      userState: userState ?? this.userState,
    );
  }

  @override
  int get hashCode =>
      //isLoading.hash Code ^
      userState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && userState == other.userState;
}

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
