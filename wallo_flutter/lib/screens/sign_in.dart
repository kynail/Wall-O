// import 'package:flutter/material.dart';
// import 'package:wallo_flutter/models/user.dart';
// import 'package:wallo_flutter/redux/state/app_state.dart';
// import 'package:wallo_flutter/redux/store.dart';
// // import 'package:redux/redux.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:wallo_flutter/redux/user/user_actions.dart';
// import 'package:wallo_flutter/redux/state/user/user_state.dart';
// import 'package:wallo_flutter/theme.dart';
// import 'package:wallo_flutter/widgets/customAppbar.dart';
// import 'package:wallo_flutter/widgets/loading_button.dart';

// class SignIn extends StatefulWidget {
//   const SignIn({Key key}) : super(key: key);

//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   bool isObscur = true;
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final firstNameController = TextEditingController();
//   final mailController = TextEditingController();
//   final passwController = TextEditingController();

//   void handleLogin(BuildContext context, bool isError, User user) {
//     if (_formKey.currentState.validate()) {
//       // Redux.store.dispatch((store) => registerUser(store, nameController.text,
//       //     firstNameController.text, mailController.text, passwController.text));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, UserState>(
//         distinct: true,
//         converter: (store) => store.state.userState,
//         onWillChange: (state, userState) {
//           // handleError(context, userState);

//           // if (userState.isError == false && userState.user != null) {
//           //   Navigator.pushReplacementNamed(context, "/home");
//           // }
//         },
//         builder: (context, userState) {
//           return Scaffold(
//               appBar: CustomAppBar(
//                 height: 180,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image(
//                       image: AssetImage("assets/wallo.png"),
//                       width: 200,
//                       height: 120,
//                     ),
//                     Text(
//                       "Bienvenue",
//                       style: TextStyle(color: Colors.white, fontSize: 23),
//                     ),
//                   ],
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 child: Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Veuillez remplir les champs ci-dessous pour vous inscrire.",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Nom"),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                                 controller: nameController,
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Veuillez remplir ce champ';
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Entrez votre nom',
//                                   border: InputBorder.none,
//                                   fillColor: Color(0xfffff6d4),
//                                   filled: true,
//                                 )),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Prénom"),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                                 controller: firstNameController,
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Veuillez remplir ce champ';
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Entrez votre Prénom',
//                                   border: InputBorder.none,
//                                   fillColor: Color(0xfffff6d4),
//                                   filled: true,
//                                 )),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Adresse e-mail"),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                                 controller: mailController,
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Veuillez remplir ce champ';
//                                   }
//                                   return null;
//                                 },
//                                 autocorrect: false,
//                                 decoration: InputDecoration(
//                                   hintText: 'Entrez une adresse e-mail',
//                                   border: InputBorder.none,
//                                   fillColor: Color(0xfffff6d4),
//                                   filled: true,
//                                 )),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Mot de passe"),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                                 controller: passwController,
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Veuillez remplir ce champ';
//                                   }
//                                   return null;
//                                 },
//                                 obscureText: (isObscur),
//                                 decoration: InputDecoration(
//                                   hintText: 'Entrez votre mot de passe',
//                                   border: InputBorder.none,
//                                   fillColor: Color(0xfffff6d4),
//                                   filled: true,
//                                   suffixIcon: IconButton(
//                                     icon: isObscur
//                                         ? Icon(Icons.visibility_off)
//                                         : Icon(Icons.visibility),
//                                     onPressed: () {
//                                       setState(() {
//                                         isObscur = !isObscur;
//                                       });
//                                     },
//                                   ),
//                                 )),
//                             SizedBox(height: 30),
//                             Center(
//                                 child: Container(
//                               width: 200,
//                               child: LoadingButton(
//                                   isLoading: false, //userState.isLoading,
//                                   onPressed: () {
//                                     // handleLogin(context, userState.isError,
//                                     //     userState.user);
//                                   },
//                                   child: Text(
//                                     "Inscription",
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                             )),
//                             SizedBox(height: 18),
//                             Center(
//                                 child: Container(
//                               width: 200,
//                               child: TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text(
//                                     "Connexion",
//                                     style: TextStyle(color: AppTheme.colorD),
//                                   )),
//                             )),
//                             SizedBox(height: 18),
//                             Center(
//                                 child: Container(
//                               width: 250,
//                               child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       primary: Colors.white,
//                                       onPrimary: Colors.black),
//                                   onPressed: () {},
//                                   child: Wrap(
//                                     crossAxisAlignment:
//                                         WrapCrossAlignment.center,
//                                     children: [
//                                       Image(
//                                         image: AssetImage("assets/google.png"),
//                                         width: 20,
//                                         height: 20,
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text("Inscription avec Google"),
//                                     ],
//                                   )),
//                             )),
//                             Center(
//                                 child: Container(
//                               width: 250,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.white,
//                                     onPrimary: Colors.black),
//                                 onPressed: () {},
//                                 child: Wrap(
//                                     crossAxisAlignment:
//                                         WrapCrossAlignment.center,
//                                     children: [
//                                       Image(
//                                         image:
//                                             AssetImage("assets/facebook.png"),
//                                         width: 20,
//                                         height: 20,
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text("Inscription avec Facebook"),
//                                     ]),
//                               ),
//                             ))
//                           ]),
//                     )),
//               ));
//         });
//   }
// }
