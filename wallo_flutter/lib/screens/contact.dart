import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

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
        builder: (context, userState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Contact"),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            drawer: CustomDrawer(),
            body: Padding(
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
                        child: Text('Envoyer'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
