import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/login_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/login_form.dart';
import 'package:wallo_flutter/widgets/customAppbar.dart';
import 'package:wallo_flutter/widgets/messenger_handler.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget buildContent(LoginViewModel viewModel) {
    return MessengerHandler(
      child: LoginForm(
          isLoading: viewModel.messenger.isLoading,
          onLoginValidationSuccess: (mail, password) =>
              viewModel.login(mail, password)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/wallo.png"),
                width: 200,
                height: 120,
              ),
              Text(
                "Bienvenue",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ],
          ),
        ),
        body: new StoreConnector<AppState, LoginViewModel>(
          distinct: true,
          converter: (store) => LoginViewModel.fromStore(store),
          builder: (_, viewModel) => buildContent(viewModel),
        ));
  }
}
