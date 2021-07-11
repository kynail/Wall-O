import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

class AquadexViewModel {
  final MessengerState messenger;
  final List<AquadexFish> aquadex;
  final User user;

  AquadexViewModel({
    this.messenger,
    this.aquadex,
    this.user,
  });

  static AquadexViewModel fromStore(Store<AppState> store) {
    return AquadexViewModel(
      messenger: store.state.messengerState,
      aquadex: store.state.fishState.aquadex,
      user: store.state.userState.user,
    );
  }
}
