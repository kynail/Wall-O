import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

class ResetPasswordForm extends StatefulWidget {
  ResetPasswordForm({Key key, this.token}) : super(key: key);

  final String token;

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.token != null) Text(widget.token),
              SizedBox(height: 20),
              Text("Nouveau mot de passe"),
              SizedBox(height: 10),
              TextFormField(
                  controller: passwController,
                  onChanged: (value) {
                    // setState(() {
                    //   _mail = value;
                    // });
                  },
                  decoration: InputDecoration(
                    hintText: 'Entrez un mot de passe',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  )),
              SizedBox(height: 20),
              Text("Confirmation du mot de passe"),
              SizedBox(height: 10),
              TextFormField(
                  controller: passw1Controller,
                  onChanged: (value) {
                    // setState(() {
                    //   _mail = value;
                    // });
                  },
                  decoration: InputDecoration(
                    hintText: 'Réécrivez votre mot de passe',
                    border: InputBorder.none,
                    fillColor: Color(0xfffff6d4),
                    filled: true,
                  )),
              SizedBox(height: 20),
              Center(
                  child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Redux.store.dispatch((store) => resetPassword(
                            store,
                            passwController.text,
                            passw1Controller.text,
                            widget.token));
                      }
                    },
                    child: Text(
                      "Modifier votre mot de passe",
                      style: TextStyle(color: Colors.white),
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
