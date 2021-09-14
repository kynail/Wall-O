import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

class ResetPasswordForm extends StatefulWidget {
  ResetPasswordForm({Key key, this.token, this.isLoading, this.onResetPassword})
      : super(key: key);

  final String token;
  final bool isLoading;
  final Function(String password, String confirmPassword) onResetPassword;

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  final passwController = TextEditingController();
  final passw1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réinitialisation de mot de passe"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Token : ${widget.token}"),
                Text("Nouveau mot de passe"),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Entrez un mot de passe',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                Text("Confirmation du mot de passe"),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: passw1Controller,
                  decoration: InputDecoration(
                    hintText: 'Réécrivez votre mot de passe',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    child: Container(
                      width: widget.isLoading ? 300 : 230,
                      child: LoadingButton(
                        isLoading: widget.isLoading,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            widget.onResetPassword(
                              passwController.text,
                              passw1Controller.text,
                            );
                          }
                        },
                        child: Text(
                          "Modifier votre mot de passe",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
