import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/models/avatar.dart';
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
    }
  } on Exception catch (_) {
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

void setAvatar(Store<AppState> store, Avatar avatar, User user) async {
  try {
    final response = await http.put(Uri.http("localhost:8080", "/game/avatar"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'id': user.id, "type": avatar.type, "seed": avatar.seed});

    if (response.statusCode == 201) {
      user.avatar = avatar;

      store.dispatch(
        SetUserStateAction(
          UserState(isError: false, isLoading: false, user: user),
        ),
      );
    } else {
      print("ERRROR");
      SetUserStateAction(UserState(
          isError: true,
          errorMessage: "Une erreur s'est produite, veuillez réessayer"));
      return;
    }
  } on Exception catch (_) {
    SetUserStateAction(UserState(
        isError: true,
        errorMessage: "Une erreur s'est produite, veuillez réessayer"));
    throw Exception("Connexion au serveur impossible");
  }
}
