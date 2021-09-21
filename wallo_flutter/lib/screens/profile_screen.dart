import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/profile_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/profile/profile.dart';
import 'package:wallo_flutter/widgets/messenger_handler.dart';

import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  final Function() onCloseArrowTap;
  const ProfileScreen({
    Key key,
    @required this.onCloseArrowTap,
  }) : super(key: key);

  Widget buildContent(ProfileViewModel viewModel, double statusBarHeight) {
    return MessengerHandler(
        child: Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Profile(
        onSaveAvatarPressed: viewModel.onSaveAvatarPressed,
        addExp: (xp) => viewModel.addExp(xp),
        user: viewModel.user,
        onCloseArrowTap: onCloseArrowTap,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: new StoreConnector<AppState, ProfileViewModel>(
        distinct: true,
        converter: (store) => ProfileViewModel.fromStore(store),
        builder: (_, viewModel) => buildContent(viewModel, statusBarHeight),
      ),
    );
  }
}
