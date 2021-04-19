import 'package:flutter/material.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

import '../route_generator.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key key, this.isLoading, this.onRegisterValidationSuccess})
      : super(key: key);

  final bool isLoading;
  final Function(String name, String firstname, String mail, String passw)
      onRegisterValidationSuccess;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isObscur = true;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final mailController = TextEditingController();
  final passwController = TextEditingController();

  void handleLogin() {
    if (_formKey.currentState.validate()) {
      widget.onRegisterValidationSuccess(nameController.text,
          firstNameController.text, mailController.text, passwController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Veuillez remplir les champs ci-dessous pour vous inscrire.",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Nom"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Entrez votre nom',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Prénom"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: firstNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Entrez votre Prénom',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  )),
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
                    isLoading: widget.isLoading,
                    onPressed: () => handleLogin(),
                    child: Text(
                      "Inscription",
                      style: TextStyle(color: Colors.white),
                    )),
              )),
              SizedBox(height: 18),
              Center(
                  child: Container(
                width: 200,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Connexion",
                      style: TextStyle(color: AppTheme.colorD),
                    )),
              )),
              SizedBox(height: 18),
              Center(
                  child: Container(
                width: 250,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    onPressed: () {
                      Keys.navKey.currentState.pushNamed(Routes.webview);
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
                        Text("Inscription avec Google"),
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
                        Text("Inscription avec Facebook"),
                      ]),
                ),
              ))
            ]),
          )),
    );
  }
}
