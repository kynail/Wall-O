import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/aquadex_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/home/aquadex.dart';

class AquadexScreen extends StatelessWidget {
  final PageController pageController;

  const AquadexScreen({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  Widget buildContent(AquadexViewModel viewModel) {
    return viewModel.aquadex == null
        ? Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Aquadex(
            user: viewModel.user,
            aquadex: viewModel.aquadex,
            pageController: pageController, onCloseArrowTap: () {  },
          );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AquadexViewModel>(
      distinct: true,
      converter: (store) => AquadexViewModel.fromStore(store),
      builder: (_, viewModel) => buildContent(viewModel),
    );
  }
}
