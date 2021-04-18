import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/messenger_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

import 'handle_snackbar.dart';

class MessengerHandler extends StatelessWidget {
  const MessengerHandler({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MessengerViewModel>(
      distinct: true,
      converter: (store) => MessengerViewModel.fromStore(store),
      builder: (context, viewModel) => child,
      onWillChange: (_, viewModel) {
        if (viewModel.messenger.showSnackbar == true) {
          viewModel.markSnackbarHandled();
          handleSnackBar(
              context,
              viewModel.messenger.errorMessage,
              viewModel.messenger.successMessage,
              viewModel.messenger.isError,
              viewModel.messenger.isLoading);
        }
      },
    );
  }
}
