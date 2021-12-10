import 'package:flutter/material.dart';
import 'package:wallo_flutter/route_generator.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onLoginValidationSuccess;
  final bool isLoading;

  LoginForm(
      {Key key,
      @required this.onLoginValidationSuccess,
      @required this.isLoading})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscur = true;
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final passwController = TextEditingController();

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
            child: Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/wallo.png"),
                      width: 200,
                      height: 120,
                      alignment: Alignment.centerRight,
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              widget.onLoginValidationSuccess(
                                  mailController.text, passwController.text);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff4BBCFC),
                            ),
                          ),
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
                            Navigator.of(context).pushNamed(Routes.signIn);
                          },
                          child: Text(
                            "Inscription",
                            style: TextStyle(color: Color(0xffFEBD72)),
                          )),
                    )),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forget);
                        },
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            color: Color(0xffFEBD72),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
          ),
        )
      ],
    );
  }
}
