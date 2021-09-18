import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key, this.isLoading, this.onSendForget})
      : super(key: key);

  final bool isLoading;
  final Function(String mail) onSendForget;

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _mail;
  final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/fondconnex.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 30,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffd1ebfb),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Text(
                                  "Saisissez l'adresse électronique utilisée lors de votre inscription et nous vous enverrons des instructions pour réinitialiser votre mot de passe.",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 20),
                              Text(
                                  "Pour des raisons de sécurité, nous ne stockons PAS votre mot de passe. Soyez donc assuré que nous ne vous enverrons jamais votre mot de passe par courrier électronique.",
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text("Adresse email"),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        validator: (value) {
                          final regexep = RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Enter an email';
                          } else if (!regexep.hasMatch(value)) {
                            return 'Enter valid Email';
                          } else
                            return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _mail = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Entrez une adresse e-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          fillColor: Color(0xffd1ebfb),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        child: LoadingButton(
                          isLoading: widget.isLoading,
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              widget.onSendForget(_mail);
                            }
                          },
                          child: Flexible(
                            child: Text(
                              "Envoyer les instructions de réinitialisation",
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
          ],
        ),
      ),
    );
  }
}
