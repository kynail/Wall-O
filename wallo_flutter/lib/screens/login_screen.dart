import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/login/login_viewmodel.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/views/login_form.dart';
import 'package:wallo_flutter/widgets/customAppbar.dart';
import 'package:wallo_flutter/widgets/handle_error.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget buildContent(LoginViewModel viewModel) {
    return LoginForm(
        isLoading: viewModel.isLoading,
        isError: viewModel.isError,
        onLoginValidationSuccess: (mail, password) =>
            viewModel.login(mail, password));
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
      body: Container(
          child: new StoreConnector<AppState, LoginViewModel>(
        converter: (store) => LoginViewModel.fromStore(store),
        builder: (_, viewModel) => buildContent(viewModel),
        onDidChange: (viewModel) {
          if (viewModel.isError) {
            handleError(
                context,
                viewModel.errorMessage,
                viewModel.successMessage,
                viewModel.isError,
                viewModel.isLoading);
            print("ERROR IN SCREEN");
          }
        },
      )),
    );
  }
}
