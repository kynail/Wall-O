import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/login/login_viewmodel.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/widgets/customAppbar.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

import '../theme.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.viewModel}) : super(key: key);

  LoginViewModel viewModel;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscur = true;
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final passwController = TextEditingController();

  Widget buildContent(LoginViewModel viewModel) {
    widget.viewModel = viewModel;
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Veuillez remplir les champs ci-dessous pour vous connecter.",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Adresse e-mail"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: mailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Entrez une adresse e-mail',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Mot de passe"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: passwController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                  obscureText: (isObscur),
                  decoration: InputDecoration(
                    hintText: 'Entrez votre mot de passe',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: isObscur
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isObscur = !isObscur;
                        });
                      },
                    ),
                  )),
              SizedBox(height: 30),
              Center(
                  child: Container(
                width: 200,
                child: LoadingButton(
                    isLoading: false, // AFFICHER LE STATE ,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        widget.viewModel
                            .login(mailController.text, passwController.text);
                        // Redux.store.dispatch((store) =>
                        //     logUser(mailController.text, passwController.text));
                      }
                    },
                    child: Text(
                      "Connexion",
                      style: TextStyle(color: Colors.white),
                    )),
              )),
              SizedBox(height: 18),
              Center(
                  child: Container(
                width: 200,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/signin");
                    },
                    child: Text(
                      "Inscription",
                      style: TextStyle(color: AppTheme.colorD),
                    )),
              )),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forget");
                    },
                    child: Text("Mot de passe oublié ?",
                        style: TextStyle(color: AppTheme.colorD))),
              ),
              SizedBox(height: 30),
              Center(
                  child: Container(
                width: 250,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    onPressed: () {
                      // showMyAlertDialog(context);
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/google.png"),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        Text("Connexion avec Google"),
                      ],
                    )),
              )),
              Center(
                  child: Container(
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, onPrimary: Colors.black),
                  onPressed: () {},
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/facebook.png"),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        Text("Connexion avec Facebook"),
                      ]),
                ),
              ))
            ]),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/wallo.png"),
              width: 200,
              height: 120,
            ),
            Text(
              "Bienvenue",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ],
        ),
      ),
      body: Container(
          child: new StoreConnector<AppState, LoginViewModel>(
        converter: (store) => LoginViewModel.fromStore(store),
        builder: (_, viewModel) => buildContent(viewModel),
        onDidChange: (viewModel) {
          if (viewModel.isError) {
            print("ERROR");
          }
        },
      )),
    );
  }
}
