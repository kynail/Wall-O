import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

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
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
        body : Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Center(
                child: Text("Besoin d'aide ?",
                    style: TextStyle(fontSize: 20))),
          ),
          Text("Objet :",
              style: TextStyle(fontSize: 15)),
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
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // Retrieve the text the that user has entered by using the
                        // TextEditingController.
                        content: Text(myController.text + myController2.text),
                      );
                      },
                  );
                }
              },
              child: Text('Envoyer'),
            ),
          ),
        ],
      ),
    ),
    );
  }
}