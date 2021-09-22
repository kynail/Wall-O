import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/login_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/webview.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({Key key}) : super(key: key);

  Widget buildContent(LoginViewModel viewModel) {
    return Webview(
      isLoading: viewModel.messenger.isLoading,
      onLoginSuccess: (url) => viewModel.logWithGoogle(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Connexion avec Google"),
            iconTheme: IconThemeData(color: Colors.white)),
        body: new StoreConnector<AppState, LoginViewModel>(
          distinct: true,
          converter: (store) => LoginViewModel.fromStore(store),
          builder: (_, viewModel) => buildContent(viewModel),
        ));
  }
}
