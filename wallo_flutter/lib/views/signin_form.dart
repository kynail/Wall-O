import 'package:flutter/material.dart';
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
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/fondconnex.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/wallo.png"),
                    width: 200,
                    height: 120,
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fillColor: Color(0xffd1ebfb),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Color(0xffd1ebfb),
                        filled: true,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: mailController,
                      validator: (value) {
                          const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+""";
                        if (value.isEmpty) {
                          return 'Veuillez remplir ce champ';
                        } else if (!RegExp(emailRegex).hasMatch(value)) {
                          return 'Veuillez entrer une adresse mail vailide';
                        }
                        return null;
                      },
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Entrez une adresse e-mail',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Color(0xffd1ebfb),
                        filled: true,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: passwController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez remplir ce champ';
                        } else if (value.length < 6) {
                          return 'Veuillez entrer au moins 6 caractères';
                        }
                        return null;
                      },
                      obscureText: (isObscur),
                      decoration: InputDecoration(
                        hintText: 'Entrez votre mot de passe',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Color(0xffd1ebfb),
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
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff4BBCFC))),
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
                          style: TextStyle(color: Color(0xffFEBD72)),
                        )),
                  )),
                  SizedBox(height: 18),
                  // Center(
                  //   child: Container(
                  //     width: 250,
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Colors.white, onPrimary: Colors.black),
                  //       onPressed: () {
                  //         Keys.navKey.currentState.pushNamed(Routes.webview);
                  //       },
                  //       child: Wrap(
                  //         crossAxisAlignment: WrapCrossAlignment.center,
                  //         children: [
                  //           Image(
                  //             image: AssetImage("assets/google.png"),
                  //             width: 20,
                  //             height: 20,
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text("Continuer avec Google"),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
