// import 'package:redux/redux.dart';
// import 'package:wallo_flutter/models/aquadex_fish.dart';
// import 'package:wallo_flutter/redux/actions/fish_actions.dart';
// import 'package:wallo_flutter/redux/actions/user_action.dart';
// import 'package:wallo_flutter/redux/state/app_state.dart';

// class ContactViewModel {
//   final bool isLoading;
//   final Function(String object, String body) sendContactEmail;

//   ContactViewModel({
//     this.isLoading,
//     this.sendContactEmail,
//   });

//   static ContactViewModel fromStore(Store<AppState> store) {
//     return ContactViewModel(
//       isLoading: store.state.messengerState.isLoading,
//       sendContactEmail: (object, body) {
//         store.dispatch(sendContact(store.state.userState.user, object, body));
//       },
//     );
//   }
// }
