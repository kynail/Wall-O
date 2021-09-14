import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/reset_password_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/screens/reset_password_form.dart';
import 'package:wallo_flutter/widgets/messenger_handler.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key key, this.token}) : super(key: key);

  final String token;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Widget buildContent(ResetPasswordViewModel viewModel) {
    return MessengerHandler(
      child: ResetPasswordForm(
        token: widget.token,
        isLoading: viewModel.messenger.isLoading,
        onResetPassword: (password, confirmPassword) =>
            viewModel.resetPassword(password, confirmPassword, widget.token),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ResetPasswordViewModel>(
      distinct: true,
      converter: (store) => ResetPasswordViewModel.fromStore(store),
      builder: (_, viewModel) => buildContent(viewModel),
    );
  }
}
