import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';
import 'package:wallo_flutter/widgets/handle_error.dart';

class Contact extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<Contact> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        distinct: true,
        converter: (store) => store.state.userState,
        onWillChange: (state, userState) {
          print("HANDLE ERROR IN CONTACT");
          handleError(context, userState);

          if (userState.isError == false && userState.isLoading == false) {
            Navigator.of(context).pushReplacementNamed("/home");
          }
        },
        builder: (context, userState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Contact"),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            drawer: CustomDrawer(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text("Besoin d'aide ?",
                                style: TextStyle(fontSize: 20))),
                      ),
                      Text("Objet :", style: TextStyle(fontSize: 15)),
                      TextFormField(
                        controller: myController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez remplir ce champ';
                          }
                          return null;
                        },
                      ),
                      Text("Détails de votre requête :",
                          style: TextStyle(fontSize: 15)),
                      TextFormField(
                        controller: myController2,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez remplir ce champ';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Container(
                          width: userState.isLoading ? 160 : 100,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                Redux.store.dispatch((store) => sendContact(
                                    store,
                                    userState.user,
                                    myController.text,
                                    myController2.text));
                              }
                            },
                            child: userState.isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                            value: null,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white)),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Envoyer',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                : Text(
                                    'Envoyer',
                                    style: TextStyle(color: Colors.white),
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
        });
  }
}
