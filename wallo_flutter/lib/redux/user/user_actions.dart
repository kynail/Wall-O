import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/redux/store.dart';

@immutable
class SetUserStateAction {
  final UserState userState;

  SetUserStateAction(this.userState);
}

setName(Store<AppState> store, String name) {
  store.dispatch(
    SetUserStateAction(
      UserState(
        isLoading: false,
        user: User.setName(name),
      ),
    ),
  );
}

// Future<void> fetchPostsAction(Store<AppState> store) async {
//   store.dispatch(SetPostsStateAction(PostsState(isLoading: true)));

//   try {
//     final response = await http.get('https://jsonplaceholder.typicode.com/posts');
//     assert(response.statusCode == 200);
//     final jsonData = json.decode(response.body);
//     store.dispatch(
//       SetPostsStateAction(
//         PostsState(
//           isLoading: false,
//           posts: IPost.listFromJson(jsonData),
//         ),
//       ),
//     );
//   } catch (error) {
//     store.dispatch(SetPostsStateAction(PostsState(isLoading: false)));
//   }
// }
