import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/profile_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/profile/profile.dart';

import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  final Function() onCloseArrowTap;
  const ProfileScreen({
    Key key,
    @required this.onCloseArrowTap,
  }) : super(key: key);

  Widget buildContent(ProfileViewModel viewModel, double statusBarHeight) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Profile(
            onSaveAvatarPressed: (seed, type) =>
                viewModel.onSaveAvatarPressed(seed, type),
            addExp: (xp) => viewModel.addExp(xp),
            user: viewModel.user,
            onCloseArrowTap: onCloseArrowTap,
            achievements: viewModel.achievements,
          ),
        ),
      ],
    );
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
        // onWillChange: (oldViewModel, viewModel) async {
        //   if (oldViewModel.messenger.showConfetti !=
        //           viewModel.messenger.showConfetti &&
        //       viewModel.messenger.showConfetti == true) {}
        // },
      ),
    );
  }
}
