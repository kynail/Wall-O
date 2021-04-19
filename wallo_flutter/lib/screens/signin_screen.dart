import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/login_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/signin_form.dart';
import 'package:wallo_flutter/widgets/customAppbar.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key key}) : super(key: key);

  Widget buildContent(LoginViewModel viewModel) {
    return SignInForm(
        isLoading: viewModel.messenger.isLoading,
        onRegisterValidationSuccess: (name, firstname, mail, passw) =>
            viewModel.register(name, firstname, mail, passw));
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
