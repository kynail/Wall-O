import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/profile_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/profile/profile.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/widgets/messenger_handler.dart';

import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  Widget buildContent(ProfileViewModel viewModel) {
    return MessengerHandler(
        child: Profile(
      addExp: (xp) => viewModel.addExp(xp),
      user: viewModel.user,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Mon Profil"),
            iconTheme: IconThemeData(color: Colors.white)),
        drawer: CustomDrawer(),
        backgroundColor: AppTheme.secondaryColor,
        body: new StoreConnector<AppState, ProfileViewModel>(
          distinct: true,
          converter: (store) => ProfileViewModel.fromStore(store),
          builder: (_, viewModel) => buildContent(viewModel),
        ));
  }
}
