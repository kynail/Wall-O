import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/level.dart';
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

Future<User> fetchUser(Store<AppState> store, String mail, String passw) async {
  try {
    final response = await http.post(Uri.http("localhost:8080", "users/login"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'mail': mail, 'password': passw});

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

void logUser(Store<AppState> store, String mail, String passw) {
  try {
    fetchUser(store, mail, passw).then((user) => {
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

void registerUser(Store<AppState> store, String name, String firstName,
    String mail, String passw) async {
  try {
    final response = await http
        .post(Uri.http("localhost:8080", "users/register"), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'mail': mail,
      'password': passw,
      "lastName": name,
      "firstName": firstName
    });

    if (response.statusCode == 201) {
      store.dispatch(SetUserStateAction(
        UserState(
            isError: false,
            user: User.fromJson(jsonDecode(response.body)["data"])),
      ));
    } else {
      UserState(
          isError: true,
          errorMessage: "Une erreur s'est produite, veuillez réessayer");
    }
  } on Exception catch (_) {
    store.dispatch(SetUserStateAction(
      UserState(isError: true, errorMessage: "Connexion au serveur impossible"),
    ));
    throw Exception("Connexion au serveur impossible");
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

void setExp(Store<AppState> store, User user, double exp) async {
  try {
    final response = await http.put(Uri.http("localhost:8080", "/game/level"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'id': user.id, "exp": exp.toStringAsFixed(0)});

    print("SET XP");
    print(exp.toString());

    if (response.statusCode == 201) {
      print("BODY");
      print(response.body);
      user.level = Level.fromJson(jsonDecode(response.body)["data"]);
      print("NEW USER LEVEL");
      print(user.level);

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

void sendContact(
    Store<AppState> store, User user, String object, String body) async {
  try {
    final response = await http.post(
        Uri.http("localhost:8080", "/users/contact"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'object': object, "message": body, "id": user.id});

    if (response.statusCode == 200) {
      print("CONTACT MAIL OK");
      store.dispatch(
        SetUserStateAction(
          UserState(isError: false, isLoading: false),
        ),
      );
    } else {
      print("CONTACT MAIL ERREUR");
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
