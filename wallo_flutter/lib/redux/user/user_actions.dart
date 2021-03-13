import 'dart:convert';
import 'dart:developer';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:http/http.dart' as http;

@immutable
class SetUserStateAction {
  final UserState userState;

  SetUserStateAction(this.userState);
}

Future<User> fetchUser(Store<AppState> store) async {
  try {
    final response = await http.post(Uri.http("localhost:8080", "users/login"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'mail': "brice.deguigne@epitech.eu", 'password': 'password'});

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)["data"]);
    } else {
      return null;
      //throw Exception('Failed to find this user');
    }
  } on Exception catch (_) {
    print("OKAY LETZGO");
    store.dispatch(SetUserStateAction(
      UserState(isError: true, errorMessage: "Connexion au serveur impossible"),
    ));
    throw Exception("Connexion au serveur impossible");
  }
}

void logUser(Store<AppState> store) {
  try {
    fetchUser(store).then((user) => {
          if (user == null)
            {
              store.dispatch(SetUserStateAction(
                UserState(
                    isError: true, errorMessage: "Utilisateur introuvable"),
              ))
            }
          else
            {
              print("USER ="),
              print(user),
              store.dispatch(
                SetUserStateAction(
                  UserState(isError: false, isLoading: false, user: user),
                ),
              )
            }
        });
  } on Exception catch (_) {
    print("IN CATCH");
  }
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
