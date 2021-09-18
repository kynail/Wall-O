import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/forget_password_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/screens/forget_password.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  Widget buildContent(ForgetPasswordViewModel viewModel) {
    return ForgetPassword(
      isLoading: viewModel.isLoading,
      onSendForget: (mail) => viewModel.onSendForget(mail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ForgetPasswordViewModel>(
      distinct: true,
      converter: (store) => ForgetPasswordViewModel.fromStore(store),
      builder: (_, viewModel) => buildContent(viewModel),
    );
  }
}
